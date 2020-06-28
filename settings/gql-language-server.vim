augroup vim_lsp_settings_gql_language_server
  au!
  LspRegisterServer {
      \ 'name': 'gql-language-server',
      \ 'cmd': {server_info->lsp_settings#get('gql-language-server', 'cmd', [lsp_settings#exec_path('gql-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('gql-language-server', 'root_uri', lsp_settings#root_uri('gql-language-server'))},
      \ 'initialization_options': lsp_settings#get('gql-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('gql-language-server', 'allowlist', ['graphql']),
      \ 'blocklist': lsp_settings#get('gql-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('gql-language-server', 'config', lsp_settings#server_config('gql-language-server')),
      \ 'workspace_config': lsp_settings#get('gql-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('gql-language-server', 'semantic_highlight', {}),
      \ }
augroup END
