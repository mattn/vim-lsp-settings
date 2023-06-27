augroup vim_lsp_settings_ols
  au!
  LspRegisterServer {
      \ 'name': 'ols',
      \ 'cmd': {server_info->lsp_settings#get('ols', 'cmd', [lsp_settings#exec_path('ols')]+lsp_settings#get('ols', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('ols', 'root_uri', lsp_settings#root_uri('ols'))},
      \ 'initialization_options': lsp_settings#get('ols', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('ols', 'allowlist', ['odin']),
      \ 'blocklist': lsp_settings#get('ols', 'blocklist', []),
      \ 'config': lsp_settings#get('ols', 'config', lsp_settings#server_config('ols')),
      \ 'workspace_config': lsp_settings#get('ols', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ols', 'semantic_highlight', {}),
      \ }
augroup END
