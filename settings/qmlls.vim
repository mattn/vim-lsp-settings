augroup vim_lsp_settings_qmlls
  au!
  LspRegisterServer {
      \ 'name': 'qmlls',
      \ 'cmd': {server_info->lsp_settings#get('qmlls', 'cmd', [lsp_settings#exec_path('qmlls')])+lsp_settings#get('qmlls', 'args', ['-E'])},
      \ 'root_uri':{server_info->lsp_settings#get('qmlls', 'root_uri', lsp_settings#root_uri('qmlls'))},
      \ 'allowlist': lsp_settings#get('qmlls', 'allowlist', ['qml', 'qmljs']),
      \ 'blocklist': lsp_settings#get('qmlls', 'blocklist', []),
      \ 'config': lsp_settings#get('qmlls', 'config', lsp_settings#server_config('pyls-all')),
      \ }
augroup END
