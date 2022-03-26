augroup vim_lsp_settings_rust_analyzer
  au!
  LspRegisterServer {
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->lsp_settings#get('rust-analyzer', 'cmd', [lsp_settings#exec_path('rust-analyzer')]+lsp_settings#get('rust-analyzer', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('rust-analyzer', 'root_uri', lsp_settings#root_uri('rust-analyzer'))},
      \ 'initialization_options': lsp_settings#get('rust-analyzer', 'initialization_options', {
      \     'completion': {
      \         'autoimport': { 'enable': v:true },
      \     },
      \ }),
      \ 'allowlist': lsp_settings#get('rust-analyzer', 'allowlist', ['rust']),
      \ 'blocklist': lsp_settings#get('rust-analyzer', 'blocklist', []),
      \ 'config': lsp_settings#get('rust-analyzer', 'config', lsp_settings#server_config('rust-analyzer')),
      \ 'workspace_config': lsp_settings#get('rust-analyzer', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rust-analyzer', 'semantic_highlight', {}),
      \ }
  autocmd User lsp_setup call s:register_command()
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function! s:on_lsp_buffer_enabled() abort
  command! -buffer LspOpenCargoToml call <SID>open_cargo_toml()
  nnoremap <buffer> <plug>(lsp-open-cargo-toml) :<c-u>call <SID>open_cargo_toml()<cr>

  command! -buffer LspCargoReload call <SID>reload_workspace()
  nnoremap <buffer> <plug>(lsp-cargo-reload) :<c-u>call <SID>reload_workspace()<cr>

  command! -buffer LspRustAnalyzerStatus call <SID>rust_analyzer_status()
  nnoremap <buffer> <plug>(lsp-rust-analyzer-status) :<c-u>call <SID>rust_analyzer_status()<cr>

  command! -range  LspRustJoinLines call <SID>join_lines()
  nnoremap <plug>(lsp-rust-join-lines) :<c-u>call <SID>join_lines()<cr>

  command! -buffer LspRustFindMatchingBrace call <SID>find_matching_brace()
  nnoremap <buffer> <plug>(lsp-rsut-find-matching-brace) :<c-u>call <SID>find_matching_brace()<cr>

  command! -buffer LspRustOpenDocs call <SID>open_docs()
  nnoremap <buffer> <plug>(lsp-rust-open-docs) :<c-u>call <SID>open_docs()<cr>
endfunction

function! s:open_cargo_toml() abort
    call lsp#callbag#pipe(
        \ lsp#request('rust-analyzer', {
        \   'method': 'experimental/openCargoToml',
        \   'params': {
        \       'textDocument': lsp#get_text_document_identifier(),
        \   }
        \ }),
        \ lsp#callbag#subscribe({
        \   'next':{x->lsp#utils#location#_open_lsp_location(x['response']['result'])},
        \   'error':{e->lsp_settings#utils#error(e)},
        \ })
        \ )
endfunction

function! s:reload_workspace() abort
    call lsp#callbag#pipe(
        \ lsp#request('rust-analyzer', {
        \   'method': 'rust-analyzer/reloadWorkspace',
        \ }),
        \ lsp#callbag#subscribe({
        \   'next': {x -> execute('echo "Cargo workspace reloaded"', '')},
        \   'error': {e -> lsp_settings#utils#error(e)},
        \ })
        \ )
endfunction

function! s:rust_analyzer_status() abort
    echo 'Retrieving rust-analyzer status'
    call lsp#callbag#pipe(
        \  lsp#request('rust-analyzer', {
        \   'method': 'rust-analyzer/analyzerStatus',
        \   'params': { 'textDocument': lsp#get_text_document_identifier() }
        \ }),
        \ lsp#callbag#subscribe({
        \   'next': {x->s:on_rust_analyzer_status(x)},
        \   'error': {e->lsp_settings#utils#error(e)},
        \ })
        \ )
endfunction

function! s:on_rust_analyzer_status(x) abort
    let l:contents = a:x['response']['result']
    let l:lines = lsp#utils#_split_by_eol(l:contents)
    let l:view = winsaveview()
    let l:alternate=@#
    silent! pclose
    sp LspRustAnalyzerStatusPreview
    execute 'resize '.min([len(l:lines), &previewheight])
    set previewwindow
    setlocal conceallevel=2
    setlocal bufhidden=hide
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal noswapfile
    %d
    call setline(1, l:lines)
    execute "normal \<c-w>p"
    call winrestview(l:view)
    let @#=l:alternate
endfunction

function! s:join_lines() abort
    echo 'Joining lines'
    call lsp#callbag#pipe(
        \  lsp#request('rust-analyzer', {
        \   'method': 'experimental/joinLines',
        \   'params': {
        \       'textDocument': lsp#get_text_document_identifier(),
        \       'ranges': [lsp#utils#range#_get_recent_visual_range()],
        \   },
        \ }),
        \ lsp#callbag#subscribe({
        \   'next': {x->s:on_join_lines(x)},
        \   'error': {e->lsp_settings#utils#error(e)},
        \ })
        \ )
endfunction

function! s:on_join_lines(x) abort
    if lsp#client#is_error(a:x['response']) | echom 'Failed to join lines' | endif
    call lsp#utils#text_edit#apply_text_edits(a:x['request']['params']['textDocument']['uri'], a:x['response']['result'])
    echo 'Joined lines'
endfunction

function! s:find_matching_brace() abort
    echo 'Finding matching brace'
    call lsp#callbag#pipe(
        \  lsp#request('rust-analyzer', {
        \   'method': 'experimental/matchingBrace',
        \   'params': {
        \       'textDocument': lsp#get_text_document_identifier(),
        \       'positions': [lsp#get_position()],
        \   },
        \ }),
        \ lsp#callbag#subscribe({
        \   'next': {x->s:on_find_matching_brace(x)},
        \   'error': {e->lsp_settings#utils#error(e)},
        \ })
        \ )
endfunction

function! s:on_find_matching_brace(x) abort
    if lsp#client#is_error(a:x['response']) | echom 'Failed to find matching brace' | endif
    let l:positions = a:x['response']['result']
    if empty(l:positions)
        echo 'No matching brace found'
    else
        " find matching brace returns multiple positions but here we only use
        " the first one
        call lsp#utils#location#_open_lsp_location({
            \ 'uri': a:x['request']['params']['textDocument']['uri'],
            \ 'range': {
            \   'start': l:positions[0],
            \   'end': l:positions[0],
            \ },
            \ })
    endif
endfunction

function! s:open_docs() abort
    echo 'Opening docs...'
    call lsp#callbag#pipe(
        \  lsp#request('rust-analyzer', {
        \   'method': 'experimental/externalDocs',
        \   'params': {
        \       'textDocument': lsp#get_text_document_identifier(),
        \       'position': lsp#get_position(),
        \   },
        \ }),
        \ lsp#callbag#subscribe({
        \   'next': {x->s:on_open_docs(x)},
        \   'error': {e->lsp_settings#utils#error(e)},
        \ })
        \ )
endfunction

function! s:on_open_docs(x) abort
    if lsp#client#is_error(a:x['response']) | echom 'Failed to find docs' | endif
    let l:url = a:x['response']['result']
    call lsp_settings#utils#open_url(l:url)
    echo ''
endfunction

function! s:rust_analyzer_apply_source_change(context) abort
    let l:command = get(a:context, 'command', {})

    let l:arguments = get(l:command, 'arguments', [])
	let l:argument = get(l:arguments, 0, {})

    let l:workspace_edit = get(l:argument, 'workspaceEdit', {})
    if !empty(l:workspace_edit)
        call lsp#utils#workspace_edit#apply_workspace_edit(l:workspace_edit)
    endif

    let l:cursor_position = get(l:argument, 'cursorPosition', {})
    if !empty(l:cursor_position)
        call cursor(lsp#utils#position#lsp_to_vim('%', l:cursor_position))
    endif
endfunction

function! s:rust_analyzer_run_single(context) abort
    let l:command = get(a:context, 'command', {})
    let l:arguments = get(l:command, 'arguments', [])
	let l:argument = get(l:arguments, 0, {})

    if !has_key(l:argument, 'kind')
        call lsp_settings#utils#error('unsupported rust-analyzer.runSingle command. ' . json_encode(l:command))
        return
    endif

    if l:argument['kind'] ==# 'cargo'
        let l:label = get(l:argument, 'label', 'cargo')
        let l:args = get(l:argument, 'args', {})
        let l:workspaceRoot = get(l:args, 'workspaceRoot', getcwd())
        let l:cargoArgs = get(l:args, 'cargoArgs', [])
        let l:cargoExtraArgs = get(l:args, 'cargoExtraArgs', [])
        let l:executableArgs = get(l:args, 'executableArgs', [])
        let l:cmd = ['cargo'] + l:cargoArgs + l:cargoExtraArgs

        if !empty(l:executableArgs)
            let l:cmd += ['--'] + l:executableArgs
        endif

        call lsp_settings#utils#term_start(l:cmd, {'cwd': l:workspaceRoot})
    else
        call lsp_settings#utils#error('unsupported rust-analyzer.runSingle command. ' . json_encode(l:command))
    endif
endfunction

function! s:register_command() abort
  if get(s:, 'setup') | return | endif
  let s:setup = 1
  augroup vimlsp_settings_rust_analyzer
    au!
  augroup END
  if exists('*lsp#register_command')
    call lsp#register_command('rust-analyzer.applySourceChange', function('s:rust_analyzer_apply_source_change'))
    call lsp#register_command('rust-analyzer.runSingle', function('s:rust_analyzer_run_single'))
  endif
endfunction
