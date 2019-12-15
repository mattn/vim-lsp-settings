augroup vimlsp_settings_gopls
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'gopls',
      \ 'cmd': lsp_settings#get('gopls', 'cmd', {server_info->[lsp_settings#exec_path('gopls')]}),
      \ 'initialization_options': lsp_settings#get('gopls', 'initialization_options', {"diagnostics": "true"}),
      \ 'whitelist': lsp_settings#get('gopls', 'whitelist', ['go']),
      \ 'blacklist': lsp_settings#get('gopls', 'blacklist', []),
      \ 'config': lsp_settings#get('gopls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('gopls', 'workspace_config', {}),
      \ })
augroup END
