augroup vimlsp_settings_texlab
  au!
  LspRegisterServer {
      \ 'name': 'texlab',
      \ 'cmd': {server_info->lsp_settings#get('texlab', 'cmd', [lsp_settings#exec_path('texlab')])},
      \ 'root_uri':{server_info->lsp_settings#get('texlab', 'root_uri', lsp_settings#root_uri('texlab'))},
      \ 'initialization_options': lsp_settings#get('texlab', 'initialization_options', {'diagnostics': 'true'}),
      \ 'whitelist': lsp_settings#get('texlab', 'whitelist', ['plaintex', 'tex']),
      \ 'blacklist': lsp_settings#get('texlab', 'blacklist', []),
      \ 'config': lsp_settings#get('texlab', 'config', lsp_settings#server_config('texlab')),
      \ 'workspace_config': lsp_settings#get('texlab', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('texlab', 'semantic_highlight', {}),
      \ }
augroup END
