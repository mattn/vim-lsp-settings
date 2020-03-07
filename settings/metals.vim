augroup vim_lsp_settings_metals
  au!
  LspRegisterServer {
      \ 'name': 'metals',
      \ 'cmd': {server_info->lsp_settings#get('metals', 'cmd', [lsp_settings#exec_path('metals')])},
      \ 'root_uri':{server_info->lsp_settings#get('metals', 'root_uri', lsp_settings#root_uri('metals'))},
      \ 'initialization_options': lsp_settings#get('metals', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('metals', 'whitelist', ['scala', 'sbt']),
      \ 'blacklist': lsp_settings#get('metals', 'blacklist', []),
      \ 'config': lsp_settings#get('metals', 'config', lsp_settings#server_config('metals')),
      \ 'workspace_config': lsp_settings#get('metals', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('metals', 'semantic_highlight', {}),
      \ }
augroup END
