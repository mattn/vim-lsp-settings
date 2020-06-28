augroup vim_lsp_settings_digestif
  au!
  LspRegisterServer {
      \ 'name': 'digestif',
      \ 'cmd': {server_info->lsp_settings#get('digestif', 'cmd', [lsp_settings#exec_path('digestif')])},
      \ 'root_uri':{server_info->lsp_settings#get('digestif', 'root_uri', lsp_settings#root_uri('digestif'))},
      \ 'initialization_options': lsp_settings#get('digestif', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('digestif', 'allowlist', ['plaintex', 'tex']),
      \ 'blocklist': lsp_settings#get('digestif', 'blocklist', []),
      \ 'config': lsp_settings#get('digestif', 'config', lsp_settings#server_config('digestif')),
      \ 'workspace_config': lsp_settings#get('digestif', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('digestif', 'semantic_highlight', {}),
      \ }
augroup END
