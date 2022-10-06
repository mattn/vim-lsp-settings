augroup vim_lsp_settings_rucoa
  au!
  LspRegisterServer {
      \ 'name': 'rucoa',
      \ 'cmd': {server_info->lsp_settings#get('rucoa', 'cmd', [lsp_settings#exec_path('rucoa')]+lsp_settings#get('rucoa', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('rucoa', 'root_uri', lsp_settings#root_uri('rucoa'))},
      \ 'initialization_options': lsp_settings#get('rucoa', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('rucoa', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('rucoa', 'blocklist', []),
      \ 'config': lsp_settings#get('rucoa', 'config', lsp_settings#server_config('rucoa')),
      \ 'workspace_config': lsp_settings#get('rucoa', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rucoa', 'semantic_highlight', {}),
      \ }
augroup END
