augroup vim_lsp_settings_graphql-language-server
  au!
  LspRegisterServer {
      \ 'name': 'graphql-language-server',
      \ 'cmd': {server_info->lsp_settings#get('graphql-language-server', 'cmd', [lsp_settings#exec_path('graphql-language-server'), 'server', '--method', 'stream'])},
      \ 'root_uri':{server_info->lsp_settings#get('graphql-language-server', 'root_uri', lsp_settings#root_uri('graphql-language-server'))},
      \ 'initialization_options': lsp_settings#get('graphql-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('graphql-language-server', 'allowlist', ['graphql']),
      \ 'blocklist': lsp_settings#get('graphql-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('graphql-language-server', 'config', lsp_settings#server_config('graphql-language-server')),
      \ 'workspace_config': lsp_settings#get('graphql-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('graphql-language-server', 'semantic_highlight', {}),
      \ }
augroup END
