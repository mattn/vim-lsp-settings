augroup vim_lsp_settings_deno
  au!
  LspRegisterServer {
      \ 'name': 'deno',
      \ 'cmd': {server_info->lsp_settings#get('deno', 'cmd', [lsp_settings#exec_path('deno'), 'lsp'])},
      \ 'root_uri':{server_info->lsp_settings#get('deno', 'root_uri', lsp_settings#root_uri('deno'))},
      \ 'initialization_options': lsp_settings#get('deno', 'initialization_options', {
      \   'enable': v:true,
      \   'lint': v:true,
      \   'unstable': v:true,
      \   'codeLens': {
      \     'implementations': v:true,
      \     'references': v:true,
      \     'referencesAllFunctions': v:true,
      \   },
      \ }),
      \ 'allowlist': lsp_settings#get('deno', 'allowlist', ['typescript', 'javascript', 'typescriptreact', 'javascriptreact']),
      \ 'blocklist': lsp_settings#get('deno', 'blocklist', {c->empty(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'node_modules/')) ? [] : ['typescript', 'javascript', 'typescriptreact', 'javascriptreact']}),
      \ 'config': lsp_settings#get('deno', 'config', lsp_settings#server_config('deno')),
      \ 'workspace_config': lsp_settings#get('deno', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('deno', 'semantic_highlight', {}),
      \ }
augroup END

function! s:open_new_buffer(ctx, server, type, data) abort
    " Based on vim-lsp/autoload/lsp/utils/location.vim s:open_location
    let l:path = a:ctx['target_uri']
    let l:line = a:ctx['target_selection_range']['start']['line'] + 1
    let l:col = a:ctx['target_selection_range']['start']['character'] + 1

    let l:buffer = bufnr(l:path)
    let l:mods = has_key(a:ctx, 'mods') ? a:ctx['mods'] : ''
    if l:mods ==# '' && &modified && !&hidden && l:buffer != bufnr('%')
        let l:mods = &splitbelow ? 'rightbelow' : 'leftabove'
    endif
    if l:mods ==# ''
        if l:buffer == bufnr('%')
            let l:cmd = ''
        else
            let l:cmd = (l:buffer !=# -1 ? 'b ' . l:buffer : 'edit ' . l:path)
        endif
    else
        let l:cmd = l:mods . ' ' . (l:buffer !=# -1 ? 'sb ' . l:buffer : 'split ' . l:path)
    endif

    let l:text = a:data['response']['result']
    execute 'silent ' l:cmd

    setlocal modifiable
    call setline(1, split(l:text, "\n"))
    setlocal noswapfile buftype=nofile
    setlocal nomodified
    setlocal nomodifiable

    execute 'call cursor(' . l:line . ',' . l:col . ')'
endfunction

function! s:handle_deno_location(ctx, server, type, data) abort "ctx = {counter, list, last_command_id, jump_if_one, mods, in_preview}
    "" Based on vim-lsp/autoload/lsp/ui/vim.vim s:handle_location()
    if a:ctx['last_command_id'] != lsp#_last_command()
        return
    endif

    let a:ctx['counter'] = a:ctx['counter'] - 1
    if lsp#client#is_error(a:data['response']) || !has_key(a:data['response'], 'result')
        call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': ' . lsp#client#error_message(a:data['response']))
        return
    else
        let a:ctx['list'] = a:ctx['list'] + lsp#utils#location#_lsp_to_vim_list(a:data['response']['result'])
    endif

    if a:ctx['counter'] == 0
        if empty(a:ctx['list'])
            if type(a:data['response']) == type(v:none)
                call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': response is null')
                return
            endif

            " deno responses contains `deno://` scheme path such as
            " `deno://https/path/to/definition.ts`.
            " vim-lsp should request `deno/virtualTextDocument` with `deno://`
            " path.
            let l:target_uri = a:data['response']['result'][0]['targetUri']
            let l:target_selection_range = a:data['response']['result'][0]['targetSelectionRange']
            if l:target_uri =~ 'deno://'
                " deno 1.7.4 response `deno://`
                " Darty hack for vim-lsp's `s:ensure_start()`.
                " `s:ensure_start()` checks path is remote uri like or not.
                " `deno://http/` is detected as remote uri and finish.
                let a:ctx['target_uri'] = l:target_uri =~ 'deno://' ? substitute(l:target_uri, '^deno:\/\/', 'deno:', '') : l:target_uri
            elseif l:target_uri =~ 'deno:/'
                " deno 1.7.5 response `deno:/`
                " deno lsp encode `@` such as `std@0.87.0` to `std%400.87.0`
                " It's hard to handle in vim-lsp, so decode `@` for filepath.
                " ref: vim-lsp/autoload/lsp/utils.vim s:decode_uri(uri)
                let a:ctx['target_uri'] = substitute(l:target_uri, '%\(\x\x\)', '\=printf("%c", str2nr(submatch(1), 16))', 'g')
            else
                " No deno cache file found
                call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': run deno cache')
                return
            endif

            let a:ctx['target_selection_range'] = l:target_selection_range
            call lsp#send_request('deno', {
                \ 'method': 'deno/virtualTextDocument',
                \ 'params': {
                \   'textDocument': {
                \     'uri': l:target_uri,
                \     'isCancellationRequested': v:false,
                \   },
                \ },
                \ 'on_notification': function('s:open_new_buffer', [a:ctx, 'deno', 'definition']),
                \ })
            return
        else
            " Same buffer jump
            call lsp#utils#tagstack#_update()

            let l:loc = a:ctx['list'][0]

            if len(a:ctx['list']) == 1 && a:ctx['jump_if_one'] && !a:ctx['in_preview']
                call lsp#utils#location#_open_vim_list_item(l:loc, a:ctx['mods'])
                echo 'Retrieved ' . a:type
                redraw
            elseif !a:ctx['in_preview']
                call setqflist([])
                call setqflist(a:ctx['list'])
                echo 'Retrieved ' . a:type
                botright copen
            else
                let l:lines = readfile(l:loc['filename'])
                if has_key(l:loc,'viewstart') " showing a locationLink
                    let l:view = l:lines[l:loc['viewstart'] : l:loc['viewend']]
                    call lsp#ui#vim#output#preview(a:server, l:view, {
                        \   'statusline': ' LSP Peek ' . a:type,
                        \   'filetype': &filetype
                        \ })
                else " showing a location
                    call lsp#ui#vim#output#preview(a:server, l:lines, {
                        \   'statusline': ' LSP Peek ' . a:type,
                        \   'cursor': { 'line': l:loc['lnum'], 'col': l:loc['col'], 'align': g:lsp_peek_alignment },
                        \   'filetype': &filetype
                        \ })
                endif
            endif
        endif
    endif
endfunction

function! s:definition() abort
    " Based on vim-lsp/autoload/lsp/ui/vim.vim s:list_location()
    let l:capabilities_func = 'lsp#capabilities#has_definition_provider(v:val)'
    let l:servers = filter(lsp#get_allowed_servers(), l:capabilities_func)
    let l:command_id = lsp#_new_command()

    let l:ctx = { 'counter': len(l:servers), 'list':[], 'last_command_id': l:command_id, 'jump_if_one': 1, 'mods': '', 'in_preview': 0 }
    if len(l:servers) == 0
        call s:not_supported('Retrieving definition')
        return
    endif
    let l:target_uri = lsp#get_text_document_identifier().uri

    " Save deno's targetUri as buffer name and vim-lsp add `file://` prefex.
    " If identifier is startwith `file://deno:`, remove `file://` prefex.
    if l:target_uri =~ 'file://deno%3A'
        let l:target_uri = substitute(l:target_uri, 'file:\/\/deno%3A', 'deno:', '')
    endif

    let l:params = {
        \   'textDocument': { 'uri': l:target_uri },
        \   'position': lsp#get_position(),
        \ }

    for l:server in l:servers
        call lsp#send_request(l:server, {
            \ 'method': 'textDocument/definition',
            \ 'params': l:params,
            \ 'on_notification': function('s:handle_deno_location', [l:ctx, l:server, 'definition']),
            \ })
    endfor
    echo 'Retrieving definition ...'
endfunction

function! s:status() abort
  let l:ctx = {
      \ 'target_uri': 'deno:/status.md',
      \ 'target_selection_range': {
      \   'end': { 'character': 0, 'line': 0 },
      \   'start': { 'character': 0, 'line': 0 }
      \ }}
  call lsp#send_request('deno', {
      \ 'method': 'deno/virtualTextDocument',
      \ 'params': {
      \     'textDocument': { 'uri': 'deno:/status.md' },
      \ },
      \ 'on_notification': function('s:open_new_buffer', [l:ctx, 'deno', 'status'])
      \ })
endfunction

function! s:handle_deno_cache(data) abort
    if lsp#client#is_error(a:data['response']) || !has_key(a:data['response'], 'result')
        redraw!
        call lsp#utils#error('deno v1.7.5 or later is required to use cache')
        return
    endif
    if a:data['response']['result'] == v:true
        " Cache file would be enabled after reload buffer.
        let l:curpos = getcurpos()
        execute 'edit ' . expand('%:p')
        call setpos('.', l:curpos)
        echo 'Cache file installed'
    endif
endfunction

function! s:cache() abort
    let l:is_download_cache = input('Download all cache files?(y/n) ', 'y')
    if l:is_download_cache =~ 'y'
      call lsp#send_request('deno', {
         \ 'method': 'deno/cache',
         \ 'params': {
         \   'referrer': lsp#get_text_document_identifier(),
         \   'uris': [],
         \ },
         \ 'on_notification': function('s:handle_deno_cache', [])
         \ })
    endif
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer LspDenoDefinition call <SID>definition()
  nnoremap <buffer> <plug>(lsp-deno-definition) :<c-u>call <SID>definition()<cr>

  command! -buffer LspDenoStatus call <SID>status()
  nnoremap <buffer> <plug>(lsp-deno-status) :<c-u>call <SID>status()<cr>

  command! -buffer LspDenoCache call <SID>cache()
  nnoremap <buffer> <plug>(lsp-deno-cache) :<c-u>call <SID>cache()<cr>
endfunction

augroup lsp_install_deno
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
