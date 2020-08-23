augroup vim_lsp_settings_zls
  au!
  LspRegisterServer {
      \ 'name': 'zls',
      \ 'cmd': {server_info->lsp_settings#get('zls', 'cmd', [lsp_settings#exec_path('zls')])},
      \ 'root_uri':{server_info->lsp_settings#get('zls', 'root_uri', lsp_settings#root_uri('zls'))},
      \ 'initialization_options': lsp_settings#get('zls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('zls', 'allowlist', ['zig']),
      \ 'blocklist': lsp_settings#get('zls', 'blocklist', []),
      \ 'config': lsp_settings#get('zls', 'config', lsp_settings#server_config('zls')),
      \ 'workspace_config': lsp_settings#get('zls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('zls', 'semantic_highlight', {}),
      \ }
augroup END
