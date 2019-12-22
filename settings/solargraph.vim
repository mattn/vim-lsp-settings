augroup vimlsp_settings_solargraph
  au!
  let settings = {
      \ 'name': 'solargraph',
      \ 'cmd': {server_info->lsp_settings#get('solargraph', 'cmd', [lsp_settings#exec_path('solargraph'), 'stdio'])},
      \ 'initialization_options': lsp_settings#get('solargraph', 'initialization_options', {"diagnostics": "true"}),
      \ 'whitelist': lsp_settings#get('solargraph', 'whitelist', ['ruby']),
      \ 'blacklist': lsp_settings#get('solargraph', 'blacklist', []),
      \ 'config': lsp_settings#get('solargraph', 'config', {}),
      \ 'workspace_config': lsp_settings#get('solargraph', 'workspace_config', {}),
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
