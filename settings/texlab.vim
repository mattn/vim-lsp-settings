augroup vim_lsp_settings_texlab
  au!
  LspRegisterServer {
      \ 'name': 'texlab',
      \ 'cmd': {server_info->lsp_settings#get('texlab', 'cmd', [lsp_settings#exec_path('texlab')])},
      \ 'root_uri':{server_info->lsp_settings#get('texlab', 'root_uri', lsp_settings#root_uri('texlab'))},
      \ 'initialization_options': lsp_settings#get('texlab', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('texlab', 'allowlist', ['plaintex', 'tex']),
      \ 'blocklist': lsp_settings#get('texlab', 'blocklist', []),
      \ 'config': lsp_settings#get('texlab', 'config', lsp_settings#server_config('texlab')),
      \ 'workspace_config': lsp_settings#get('texlab', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('texlab', 'semantic_highlight', {}),
      \ }
augroup END
