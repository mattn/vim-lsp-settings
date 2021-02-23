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

function! s:handle_deno_status(ctx, server, type, data) abort
    let l:path = 'deno:/status.md'
    let l:buffer = bufnr(l:path)

    let l:mods = has_key(a:ctx, 'mods') ? a:ctx['mods'] : ''
    if l:mods ==# '' && &modified && !&hidden && l:buffer != bufnr('%')
        let l:mods = &splitbelow ? 'rightbelow' : 'leftabove'
    endif
    if l:mods ==# ''
        if l:buffer == bufnr('%')
            let l:cmd = ''
        else
            let l:cmd = (l:buffer !=# -1 ? 'b ' . l:buffer : 'edit ' . fnameescape(l:path))
        endif
    else
        let l:cmd = l:mods . ' ' . (l:buffer !=# -1 ? 'sb ' . l:buffer : 'split ' . fnameescape(l:path))
    endif

    let l:text = a:data['response']['result']
    execute 'silent ' l:cmd

    setlocal modifiable
    call setline(1, split(l:text, "\n"))
    setlocal noswapfile buftype=nofile
    setlocal nomodified
    setlocal nomodifiable
endfunction

function! s:status() abort
  let l:ctx = {}
  call lsp#send_request('deno', {
      \ 'method': 'deno/virtualTextDocument',
      \ 'params': {
      \     'textDocument': { 'uri': 'deno:/status.md' },
      \ },
      \ 'on_notification': function('s:handle_deno_status', [l:ctx, 'deno', 'status'])
      \ })
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer LspDenoStatus call <SID>status()
  nnoremap <buffer> <plug>(lsp-deno-status) :<c-u>call <SID>status()<cr>
endfunction

augroup lsp_install_deno
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
