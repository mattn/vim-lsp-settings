augroup vim_lsp_settings_angular_language_service
  au!
  LspRegisterServer {
      \ 'name': 'angular-language-service',
      \ 'cmd': {server_info->lsp_settings#get('angular-language-service', 'cmd', [lsp_settings#exec_path('angular-language-service'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('angular-language-service', 'root_uri', lsp_settings#root_uri('angular-language-service'))},
      \ 'initialization_options': lsp_settings#get('angular-language-service', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('angular-language-service', 'allowlist', {x-> empty(lsp_settings#root_path(['angular.json'])) ? [] : ['html']}),
      \ 'blocklist': lsp_settings#get('angular-language-service', 'blocklist', []),
      \ 'config': lsp_settings#get('angular-language-service', 'config', lsp_settings#server_config('angular-language-service')),
      \ 'workspace_config': lsp_settings#get('angular-language-service', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('angular-language-service', 'semantic_highlight', {}),
      \ }
augroup END
