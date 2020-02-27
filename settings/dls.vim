augroup vimlsp_settings_dls
  au!
  LspRegisterServer {
      \ 'name': 'dls',
      \ 'cmd': {server_info->lsp_settings#get('dls', 'cmd', [lsp_settings#exec_path('dls')])},
      \ 'root_uri':{server_info->lsp_settings#get('dls', 'root_uri', lsp_settings#root_uri('dls'))},
      \ 'initialization_options': lsp_settings#get('dls', 'initialization_options', {'diagnostics': 'true'}),
      \ 'whitelist': lsp_settings#get('dls', 'whitelist', ['d']),
      \ 'blacklist': lsp_settings#get('dls', 'blacklist', []),
      \ 'config': lsp_settings#get('dls', 'config', lsp_settings#server_config('dls')),
      \ 'workspace_config': lsp_settings#get('dls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('dls', 'semantic_highlight', {}),
      \ }
augroup END
