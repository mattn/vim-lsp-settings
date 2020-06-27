augroup vim_lsp_settings_sql_language_server
  au!
  LspRegisterServer {
      \ 'name': 'sql-language-server',
      \ 'cmd': {server_info->lsp_settings#get('sql-language-server', 'cmd', [lsp_settings#exec_path('sql-language-server'), 'up', '--method', 'stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('sql-language-server', 'root_uri', lsp_settings#root_uri('sql-language-server'))},
      \ 'initialization_options': lsp_settings#get('sql-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('sql-language-server', 'allowlist', ['sql']),
      \ 'blocklist': lsp_settings#get('sql-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('sql-language-server', 'config', lsp_settings#server_config('sql-language-server')),
      \ 'workspace_config': lsp_settings#get('sql-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('sql-language-server', 'semantic_highlight', {}),
      \ }
augroup END
