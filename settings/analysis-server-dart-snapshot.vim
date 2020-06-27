augroup vim_lsp_settings_analysis_server_dart_snapshot
  au!
  LspRegisterServer {
      \ 'name': 'analysis-server-dart-snapshot',
      \ 'cmd': {server_info->lsp_settings#get('analysis-server-dart-snapshot', 'cmd', [lsp_settings#exec_path('analysis-server-dart-snapshot')])},
      \ 'root_uri':{server_info->lsp_settings#get('analysis-server-dart-snapshot', 'root_uri', lsp_settings#root_uri('analysis-server-dart-snapshot'))},
      \ 'initialization_options': lsp_settings#get('analysis-server-dart-snapshot', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('analysis-server-dart-snapshot', 'allowlist', ['dart']),
      \ 'blocklist': lsp_settings#get('analysis-server-dart-snapshot', 'blocklist', []),
      \ 'config': lsp_settings#get('analysis-server-dart-snapshot', 'config', lsp_settings#server_config('analysis-server-dart-snapshot')),
      \ 'workspace_config': lsp_settings#get('analysis-server-dart-snapshot', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('analysis-server-dart-snapshot', 'semantic_highlight', {}),
      \ }
augroup END
