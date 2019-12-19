augroup vimlsp_settings_dockerfile_language_server_nodejs
  au!
  let settings = {
      \ 'name': 'docker-langserver',
      \ 'cmd': {server_info->lsp_settings#get('docker-langserver', 'cmd', [lsp_settings#exec_path('docker-langserver'), '--stdio'])},
      \ 'whitelist': lsp_settings#get('docker-langserver', 'whitelist', ['dockerfile']),
      \ 'blacklist': lsp_settings#get('docker-langserver', 'blacklist', []),
      \ 'config': lsp_settings#get('docker-langserver', 'config', {}),
      \ 'workspace_config': lsp_settings#get('docker-langserver', 'workspace_config', {}),
      \ }
  if has('patch-8.1.000')
    autocmd User lsp_setup ++once call lsp#register_server(settings)
  else
    autocmd User lsp_setup call lsp#register_server(settings)
  endif
augroup END
