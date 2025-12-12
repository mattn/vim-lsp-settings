augroup vim_lsp_settings_crystalline
  au!
  LspRegisterServer {
      \ 'name': 'crystalline',
      \ 'cmd': {server_info->lsp_settings#get('crystalline', 'cmd', [lsp_settings#exec_path('crystalline')]+lsp_settings#get('crystalline', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('crystalline', 'root_uri', lsp_settings#root_uri('crystalline'))},
      \ 'initialization_options': lsp_settings#get('crystalline', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('crystalline', 'allowlist', ['crystal']),
      \ 'blocklist': lsp_settings#get('crystalline', 'blocklist', []),
      \ 'config': lsp_settings#get('crystalline', 'config', lsp_settings#server_config('crystalline')),
      \ 'workspace_config': lsp_settings#get('crystalline', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('crystalline', 'semantic_highlight', {}),
      \ }
augroup END
