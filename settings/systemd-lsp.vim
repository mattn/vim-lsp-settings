augroup vim_lsp_settings_system_lsp
  au!
  LspRegisterServer {
      \ 'name': 'systemd-lsp',
      \ 'cmd': {server_info->lsp_settings#get('systemd-lsp', 'cmd', [lsp_settings#exec_path('systemd-lsp')]+lsp_settings#get('systemd-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('systemd-lsp', 'root_uri', lsp_settings#root_uri('systemd-lsp'))},
      \ 'initialization_options': lsp_settings#get('systemd-lsp', 'initialization_options', {
      \     'completion': {
      \         'autoimport': { 'enable': v:true },
      \     },
      \ }),
      \ 'allowlist': lsp_settings#get('systemd-lsp', 'allowlist', ['systemd']),
      \ 'blocklist': lsp_settings#get('systemd-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('systemd-lsp', 'config', lsp_settings#server_config('systemd-lsp')),
      \ 'workspace_config': lsp_settings#get('systemd-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('systemd-lsp', 'semantic_highlight', {}),
      \ }
augroup END
