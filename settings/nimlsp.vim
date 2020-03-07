augroup vim_lsp_settings_nimlsp
  au!
  LspRegisterServer {
      \ 'name': 'nimlsp',
      \ 'cmd': {server_info->lsp_settings#get('nimlsp', 'cmd', [lsp_settings#exec_path('nimlsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('nimlsp', 'root_uri', lsp_settings#root_uri('nimlsp'))},
      \ 'initialization_options': lsp_settings#get('nimlsp', 'initialization_options', {'diagnostics': 'true'}),
      \ 'whitelist': lsp_settings#get('nimlsp', 'whitelist', ['nim']),
      \ 'blacklist': lsp_settings#get('nimlsp', 'blacklist', []),
      \ 'config': lsp_settings#get('nimlsp', 'config', lsp_settings#server_config('nimlsp')),
      \ 'workspace_config': lsp_settings#get('nimlsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('nimlsp', 'semantic_highlight', {}),
      \ }
augroup END
