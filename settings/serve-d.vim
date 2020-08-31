augroup vim_lsp_settings_serve_d
  au!
  LspRegisterServer {
      \ 'name': 'serve-d',
      \ 'cmd': {server_info->lsp_settings#get('serve-d', 'cmd', [lsp_settings#exec_path('serve-d')])},
      \ 'root_uri':{server_info->lsp_settings#get('serve-d', 'root_uri', lsp_settings#root_uri('serve-d'))},
      \ 'initialization_options': lsp_settings#get('serve-d', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('serve-d', 'allowlist', ['d']),
      \ 'blocklist': lsp_settings#get('serve-d', 'blocklist', []),
      \ 'config': lsp_settings#get('serve-d', 'config', lsp_settings#server_config('serve-d')),
      \ 'workspace_config': lsp_settings#get('serve-d', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('serve-d', 'semantic_highlight', {}),
      \ }
augroup END
