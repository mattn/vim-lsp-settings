augroup vimlsp_settings_monastery
  au!
  LspRegisterServer {
      \ 'name': 'monastery',
      \ 'cmd': {server_info->lsp_settings#get('monastery', 'cmd', [lsp_settings#exec_path('monastery')])},
      \ 'root_uri':{server_info->lsp_settings#get('monastery', 'root_uri', lsp_settings#root_uri('monastery'))},
      \ 'initialization_options': lsp_settings#get('monastery', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('monastery', 'whitelist', ['perl']),
      \ 'blacklist': lsp_settings#get('monastery', 'blacklist', []),
      \ 'config': lsp_settings#get('monastery', 'config', lsp_settings#server_config('monastery')),
      \ 'workspace_config': lsp_settings#get('monastery', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('monastery', 'semantic_highlight', {}),
      \ }
augroup END
