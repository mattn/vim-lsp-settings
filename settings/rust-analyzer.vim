augroup vimlsp_settings_rust-analyzer
  au!
  LspRegisterServer {
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->lsp_settings#get('rust-analyzer', 'cmd', [lsp_settings#exec_path('rust-analyzer')])},
      \ 'root_uri':{server_info->lsp_settings#get('rust-analyzer', 'root_uri', lsp_settings#root_uri('rust-analyzer'))},
      \ 'initialization_options': lsp_settings#get('rust-analyzer', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('rust-analyzer', 'whitelist', ['rust']),
      \ 'blacklist': lsp_settings#get('rust-analyzer', 'blacklist', []),
      \ 'config': lsp_settings#get('rust-analyzer', 'config', lsp_settings#server_config('rust-analyzer')),
      \ 'workspace_config': lsp_settings#get('rust-analyzer', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rust-analyzer', 'semantic_highlight', {}),
      \ }
augroup END

function! s:rust_analyzer_apply_source_change(context)
    let l:command = get(a:context, 'command', {})

    let l:workspace_edit = get(l:command['arguments'][0], 'workspaceEdit', {})
    if !empty(l:workspace_edit)
        call lsp#utils#workspace_edit#apply_workspace_edit(l:workspace_edit)
    endif

    let l:cursor_position = get(l:command['arguments'][0], 'cursorPosition', {})
    if !empty(l:cursor_position)
        call cursor(lsp#utils#position#_lsp_to_vim('%', l:cursor_position))
    endif
endfunction
call lsp#register_command('rust-analyzer.applySourceChange', function('s:rust_analyzer_apply_source_change'))
