augroup vimlsp_settings_analysis_server_dart_snapshot
  au!
  LspRegisterServer {
      \ 'name': 'analysis-server-dart-snapshot',
      \ 'cmd': {server_info->lsp_settings#get('analysis-server-dart-snapshot', 'cmd', [lsp_settings#exec_path('analysis-server-dart-snapshot')])},
      \ 'root_uri':{server_info->lsp_settings#get('analysis-server-dart-snapshot', 'root_uri', lsp_settings#root_uri('analysis-server-dart-snapshot'))},
      \ 'initialization_options': lsp_settings#get('analysis-server-dart-snapshot', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('analysis-server-dart-snapshot', 'whitelist', ['dart']),
      \ 'blacklist': lsp_settings#get('analysis-server-dart-snapshot', 'blacklist', []),
      \ 'config': lsp_settings#get('analysis-server-dart-snapshot', 'config', lsp_settings#server_config('analysis-server-dart-snapshot')),
      \ 'workspace_config': lsp_settings#get('analysis-server-dart-snapshot', 'workspace_config', {}),
      \ }
augroup END
