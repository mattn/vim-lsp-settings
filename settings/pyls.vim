augroup vimlsp_settings_pyls
  au!
  let settings = {
      \ 'name': 'pyls',
      \ 'cmd': {server_info->lsp_settings#get('pyls', 'cmd', [lsp_settings#exec_path('pyls')])},
      \ 'initialization_options': lsp_settings#get('pyls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('pyls', 'whitelist', ['python']),
      \ 'blacklist': lsp_settings#get('pyls', 'blacklist', []),
      \ 'config': lsp_settings#get('pyls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('pyls', 'workspace_config', {}),
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
