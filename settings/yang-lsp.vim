augroup vim_lsp_settings_yang_lsp
  au!
  LspRegisterServer {
      \ 'name': 'yang-lsp',
      \ 'cmd': {server_info->lsp_settings#get('yang-lsp', 'cmd', [lsp_settings#exec_path('yang-lsp')]+lsp_settings#get('yang-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('yang-lsp', 'root_uri', lsp_settings#root_uri('yang-lsp'))},
      \ 'initialization_options': lsp_settings#get('yang-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('yang-lsp', 'allowlist', ['yang']),
      \ 'blocklist': lsp_settings#get('yang-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('yang-lsp', 'config', lsp_settings#server_config('yang-lsp')),
      \ 'workspace_config': lsp_settings#get('yang-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('yang-lsp', 'semantic_highlight', {}),
      \ }
augroup END
