augroup vim_lsp_settings_tsp_server
  au!
  LspRegisterServer {
      \ 'name': 'tsp-server',
      \ 'cmd': {server_info->lsp_settings#get('tsp-server', 'cmd', [lsp_settings#exec_path('tsp-server')]+lsp_settings#get('tsp-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('tsp-server', 'root_uri', lsp_settings#root_uri('tsp-server'))},
      \ 'initialization_options': lsp_settings#get('tsp-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('tsp-server', 'allowlist', ['typespec']),
      \ 'blocklist': lsp_settings#get('tsp-server', 'blocklist', []),
      \ 'config': lsp_settings#get('tsp-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('tsp-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('tsp-server', 'semantic_highlight', {}),
      \ }
augroup END
