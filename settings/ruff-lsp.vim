augroup vim_lsp_settings_ruff_lsp
  au!
  LspRegisterServer {
      \ 'name': 'ruff-lsp',
      \ 'cmd': {server_info->lsp_settings#get('ruff-lsp', 'cmd', [lsp_settings#exec_path('ruff-lsp')]+lsp_settings#get('ruff-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('ruff-lsp', 'root_uri', lsp_settings#root_uri('ruff-lsp'))},
      \ 'initialization_options': lsp_settings#get('ruff-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('ruff-lsp', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('ruff-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('ruff-lsp', 'config', lsp_settings#server_config('ruff-lsp')),
      \ 'workspace_config': lsp_settings#get('ruff-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ruff-lsp', 'semantic_highlight', {}),
      \ }
augroup END
