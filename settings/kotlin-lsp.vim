augroup vim_lsp_settings_kotlin_lsp
  au!
  LspRegisterServer {
      \ 'name': 'kotlin-lsp',
      \ 'cmd': {server_info->lsp_settings#get('kotlin-lsp', 'cmd', [lsp_settings#exec_path('kotlin-lsp')]+lsp_settings#get('kotlin-lsp', 'args', ["--stdio"]))},
      \ 'root_uri':{server_info->lsp_settings#get('kotlin-lsp', 'root_uri', lsp_settings#root_uri('kotlin-lsp'))},
      \ 'initialization_options': lsp_settings#get('kotlin-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('kotlin-lsp', 'allowlist', ['kotlin']),
      \ 'blocklist': lsp_settings#get('kotlin-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('kotlin-lsp', 'config', lsp_settings#server_config('kotlin-lsp')),
      \ 'workspace_config': lsp_settings#get('kotlin-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('kotlin-lsp', 'semantic_highlight', {}),
      \ }
augroup END
