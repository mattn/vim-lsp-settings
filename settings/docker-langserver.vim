augroup vim_lsp_settings_dockerfile_language_server_nodejs
  au!
  LspRegisterServer {
      \ 'name': 'docker-langserver',
      \ 'cmd': {server_info->lsp_settings#get('docker-langserver', 'cmd', [lsp_settings#exec_path('docker-langserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('docker-langserver', 'root_uri', lsp_settings#root_uri('docker-langserver'))},
      \ 'initialization_options': lsp_settings#get('docker-langserver', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('docker-langserver', 'allowlist', ['dockerfile']),
      \ 'blocklist': lsp_settings#get('docker-langserver', 'blocklist', []),
      \ 'config': lsp_settings#get('docker-langserver', 'config', lsp_settings#server_config('docker-langserver')),
      \ 'workspace_config': lsp_settings#get('docker-langserver', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('docker-langserver', 'semantic_highlight', {}),
      \ }
augroup END
