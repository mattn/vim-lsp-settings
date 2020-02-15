augroup vimlsp_settings_digestif
  au!
  LspRegisterServer {
      \ 'name': 'digestif',
      \ 'cmd': {server_info->lsp_settings#get('digestif', 'cmd', [lsp_settings#exec_path('digestif')])},
      \ 'root_uri':{server_info->lsp_settings#get('digestif', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('digestif', 'initialization_options', {'diagnostics': 'true'}),
      \ 'whitelist': lsp_settings#get('digestif', 'whitelist', ['plaintex', 'tex']),
      \ 'blacklist': lsp_settings#get('digestif', 'blacklist', []),
      \ 'config': lsp_settings#get('digestif', 'config', lsp_settings#server_config('digestif')),
      \ 'workspace_config': lsp_settings#get('digestif', 'workspace_config', {}),
      \ }
augroup END
