augroup vim_lsp_settings_hie
  au!
  LspRegisterServer {
      \ 'name': 'hie',
      \ 'cmd': {server_info->lsp_settings#get('hie', 'cmd', [lsp_settings#exec_path('hie-wrapper'), "--lsp"])},
      \ 'root_uri':{server_info->lsp_settings#get('hie', 'root_uri', lsp_settings#root_uri('hie'))},
      \ 'initialization_options': lsp_settings#get('hie', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('hie', 'allowlist', ['haskell']),
      \ 'blocklist': lsp_settings#get('hie', 'blocklist', []),
      \ 'config': lsp_settings#get('hie', 'config', lsp_settings#server_config('hie')),
      \ 'workspace_config': lsp_settings#get('hie', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('hie', 'semantic_highlight', {}),
      \ }
augroup END
