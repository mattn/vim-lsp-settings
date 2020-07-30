augroup vim_lsp_settings_angular_language_server
  au!
  LspRegisterServer {
      \ 'name': 'angular-language-server',
      \ 'cmd': {server_info->lsp_settings#get('angular-language-server', 'cmd', [lsp_settings#exec_path('angular-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('angular-language-server', 'root_uri', lsp_settings#root_uri('angular-language-server'))},
      \ 'initialization_options': lsp_settings#get('angular-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('angular-language-server', 'allowlist', {x-> empty(lsp_settings#root_path(['angular.json'])) ? [] : ['html']}),
      \ 'blocklist': lsp_settings#get('angular-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('angular-language-server', 'config', lsp_settings#server_config('angular-language-server')),
      \ 'workspace_config': lsp_settings#get('angular-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('angular-language-server', 'semantic_highlight', {}),
      \ }
augroup END
