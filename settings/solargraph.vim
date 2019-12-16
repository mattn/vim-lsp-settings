augroup vimlsp_settings_solargraph
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'solargraph',
      \ 'cmd': {server_info->lsp_settings#get('solargraph', 'cmd', [lsp_settings#exec_path('solargraph'), 'stdio'])},
      \ 'initialization_options': lsp_settings#get('solargraph', 'initialization_options', {"diagnostics": "true"}),
      \ 'whitelist': lsp_settings#get('solargraph', 'whitelist', ['ruby']),
      \ 'blacklist': lsp_settings#get('solargraph', 'blacklist', []),
      \ 'config': lsp_settings#get('solargraph', 'config', {}),
      \ 'workspace_config': lsp_settings#get('solargraph', 'workspace_config', {}),
      \ })
augroup END
