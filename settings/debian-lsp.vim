augroup vim_lsp_settings_debian_lsp
  au!
  LspRegisterServer {
      \ 'name': 'debian-lsp',
      \ 'cmd': {server_info->lsp_settings#get('debian-lsp', 'cmd', [lsp_settings#exec_path('debian-lsp')]+lsp_settings#get('debian-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('debian-lsp', 'root_uri', lsp_settings#root_uri('debian-lsp'))},
      \ 'allowlist': lsp_settings#get('debian-lsp', 'allowlist', ['debcontrol', 'debcopyright', 'debchangelog', 'debsources', 'debwatch', 'debupstream', 'autopkgtest']),
      \ 'blocklist': lsp_settings#get('debian-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('debian-lsp', 'config', lsp_settings#server_config('debian-lsp')),
      \ }
augroup END
