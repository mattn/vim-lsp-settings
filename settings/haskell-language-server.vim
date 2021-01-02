augroup vim_lsp_settings_haskell_language_server
  au!
  LspRegisterServer {
      \ 'name': 'haskell-language-server',
      \ 'cmd': {server_info->lsp_settings#get('haskell-language-server', 'cmd', [lsp_settings#exec_path('haskell-language-server-wrapper'), '--lsp'])},
      \ 'root_uri':{server_info->lsp_settings#get('haskell-language-server', 'root_uri', lsp_settings#root_uri('haskell-language-server'))},
      \ 'initialization_options': lsp_settings#get('haskell-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('haskell-language-server', 'allowlist', ['haskell']),
      \ 'blocklist': lsp_settings#get('haskell-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('haskell-language-server', 'config', lsp_settings#server_config('haskell-language-server')),
      \ 'workspace_config': lsp_settings#get('haskell-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('haskell-language-server', 'semantic_highlight', {}),
      \ }
augroup END
