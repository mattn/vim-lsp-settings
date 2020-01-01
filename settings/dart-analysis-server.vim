augroup vimlsp_settings_dart_analysis_server
  au!
  LspRegisterServer {
      \ 'name': 'dart-analysis-server',
      \ 'cmd': {server_info->lsp_settings#get('dart-analysis-server', 'cmd', [lsp_settings#exec_path('dart-analysis-server'), '--lsp'])},
      \ 'root_uri':{server_info->lsp_settings#get('dart-analysis-server', 'root_uri', lsp_settings#root_uri(['.git/']))},
      \ 'initialization_options': lsp_settings#get('dart-analysis-server', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('dart-analysis-server', 'whitelist', ['dart']),
      \ 'blacklist': lsp_settings#get('dart-analysis-server', 'blacklist', []),
      \ 'config': lsp_settings#get('dart-analysis-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('dart-analysis-server', 'workspace_config', {}),
      \ }
augroup END
