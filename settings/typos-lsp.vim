augroup vim_lsp_settings_typos_lsp
  au!
  LspRegisterServer {
      \ 'name': 'typos-lsp',
      \ 'cmd': {server_info->lsp_settings#get('typos-lsp', 'cmd', [lsp_settings#exec_path('typos-lsp')]+lsp_settings#get('typos-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('typos-lsp', 'root_uri', lsp_settings#root_uri('typos-lsp'))},
      \ 'initialization_options': lsp_settings#get('typos-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('typos-lsp', 'allowlist', ['*']),
      \ 'blocklist': lsp_settings#get('typos-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('typos-lsp', 'config', lsp_settings#server_config('typos-lsp')),
      \ 'workspace_config': lsp_settings#get('typos-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('typos-lsp', 'semantic_highlight', {}),
      \ }
augroup END
