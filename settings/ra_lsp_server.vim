augroup vimlsp_settings_ra_lsp_server
  au!
  LspRegisterServer {
      \ 'name': 'ra_lsp_server',
      \ 'cmd': {server_info->lsp_settings#get('ra_lsp_server', 'cmd', [lsp_settings#exec_path('ra_lsp_server')])},
      \ 'root_uri':{server_info->lsp_settings#get('ra_lsp_server', 'root_uri', lsp_settings#root_uri('ra_lsp_server'))},
      \ 'initialization_options': lsp_settings#get('ra_lsp_server', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('ra_lsp_server', 'whitelist', ['rust']),
      \ 'blacklist': lsp_settings#get('ra_lsp_server', 'blacklist', []),
      \ 'config': lsp_settings#get('ra_lsp_server', 'config', lsp_settings#server_config('ra_lsp_server')),
      \ 'workspace_config': lsp_settings#get('ra_lsp_server', 'workspace_config', {}),
      \ }
augroup END
