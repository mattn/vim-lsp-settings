augroup vimlsp_settings_gopls
  au!
  LspRegisterServer {
      \ 'name': 'gopls',
      \ 'cmd': {server_info->lsp_settings#get('gopls', 'cmd', [lsp_settings#exec_path('gopls')])},
      \ 'root_uri':{server_info->lsp_settings#get('gopls', 'root_uri', lsp_settings#root_uri('gopls'))},
      \ 'initialization_options': lsp_settings#get('gopls', 'initialization_options', {"diagnostics": v:true, 'completeUnimported': v:true, 'matcher': 'fuzzy'}),
      \ 'whitelist': lsp_settings#get('gopls', 'whitelist', ['go']),
      \ 'blacklist': lsp_settings#get('gopls', 'blacklist', []),
      \ 'config': lsp_settings#get('gopls', 'config', lsp_settings#server_config('gopls')),
      \ 'workspace_config': lsp_settings#get('gopls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('gopls', 'semantic_highlight', {}),
      \ }
augroup END
