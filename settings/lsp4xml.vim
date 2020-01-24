augroup vimlsp_settings_lsp4xml
  au!
  LspRegisterServer {
      \ 'name': 'lsp4xml',
      \ 'cmd': {server_info->lsp_settings#get('lsp4xml', 'cmd', [lsp_settings#exec_path('lsp4xml')])},
      \ 'root_uri':{server_info->lsp_settings#get('lsp4xml', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('lsp4xml', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('lsp4xml', 'whitelist', ['xml']),
      \ 'blacklist': lsp_settings#get('lsp4xml', 'blacklist', []),
      \ 'config': lsp_settings#get('lsp4xml', 'config', {}),
      \ 'workspace_config': lsp_settings#get('lsp4xml', 'workspace_config', {}),
      \ }
augroup END
