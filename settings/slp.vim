augroup vim_lsp_settings_slp
  au!
  LspRegisterServer {
      \ 'name': 'slp',
      \ 'cmd': {server_info->lsp_settings#get('slp', 'cmd', [lsp_settings#exec_path('slp')])},
      \ 'root_uri':{server_info->lsp_settings#get('slp', 'root_uri', lsp_settings#root_uri('slp'))},
      \ 'initialization_options': lsp_settings#get('slp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('slp', 'allowlist', ['perl']),
      \ 'blocklist': lsp_settings#get('slp', 'blocklist', []),
      \ 'config': lsp_settings#get('slp', 'config', lsp_settings#server_config('slp')),
      \ 'workspace_config': lsp_settings#get('slp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('slp', 'semantic_highlight', {}),
      \ }
augroup END
