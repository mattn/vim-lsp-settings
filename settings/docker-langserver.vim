augroup vimlsp_settings_dockerfile_language_server_nodejs
  au!
  LspRegisterServer {
      \ 'name': 'docker-langserver',
      \ 'cmd': {server_info->lsp_settings#get('docker-langserver', 'cmd', [lsp_settings#exec_path('docker-langserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('docker-langserver', 'root_uri', lsp_settings#root_uri('docker-langserver'))},
      \ 'initialization_options': lsp_settings#get('docker-langserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('docker-langserver', 'whitelist', ['dockerfile']),
      \ 'blacklist': lsp_settings#get('docker-langserver', 'blacklist', []),
      \ 'config': lsp_settings#get('docker-langserver', 'config', lsp_settings#server_config('docker-langserver')),
      \ 'workspace_config': lsp_settings#get('docker-langserver', 'workspace_config', {}),
      \ }
augroup END
