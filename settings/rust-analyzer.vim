augroup vim_lsp_settings_rust_analyzer
  au!
  LspRegisterServer {
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->lsp_settings#get('rust-analyzer', 'cmd', [lsp_settings#exec_path('rust-analyzer')])},
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
      \ 'capabilities': lsp_settings#get('rust-analyzer', 'capabilities', {'window': {'workDoneProgress': v:true }}),
      \ 'semantic_highlight': lsp_settings#get('rust-analyzer', 'semantic_highlight', {}),
      \ }
  autocmd User lsp_setup call s:register_command()

  call lsp#callbag#pipe(
        \ lsp#stream(),
        \ lsp#callbag#filter({x->has_key(x, 'response') && has_key(x['response'], 'method')
        \  && x['response']['method'] ==# '$/progress' && has_key(x['response'], 'params')
        \  && has_key(x['response']['params'], 'value') && type(x['response']['params']['value']) == type({})}),
        \  lsp#callbag#map({x->x['response']['params']}),
        \  lsp#callbag#subscribe(funcref('lsp_settings#utils#handle_work_done_progress')),
        \ )
augroup END

function! s:rust_analyzer_apply_source_change(context)
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

let s:setup = 0

function! s:register_command()
  if s:setup == 1
    return
  endif
  let s:setup = 1
  augroup vimlsp_settings_rust_analyzer
    au!
  augroup END
  if exists('*lsp#register_command')
    call lsp#register_command('rust-analyzer.applySourceChange', function('s:rust_analyzer_apply_source_change'))
  endif
endfunction
