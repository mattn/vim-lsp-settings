augroup vim_lsp_settings_cmake-language-server
  au!
  LspRegisterServer {
      \ 'name': 'cmake-language-server',
      \ 'cmd': {server_info->lsp_settings#get('cmake-language-server', 'cmd', [lsp_settings#exec_path('cmake-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('cmake-language-server', 'root_uri', lsp_settings#root_uri('cmake-language-server'))},
      \ 'initialization_options': lsp_settings#get('cmake-language-server', 'initialization_options', {'buildDirectory': 'build'}),
      \ 'allowlist': lsp_settings#get('cmake-language-server', 'allowlist', ['cmake']),
      \ 'blocklist': lsp_settings#get('cmake-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('cmake-language-server', 'config', lsp_settings#server_config('cmake-language-server')),
      \ 'workspace_config': lsp_settings#get('cmake-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('cmake-language-server', 'semantic_highlight', {}),
      \ }
augroup END
