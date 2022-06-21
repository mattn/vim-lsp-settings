" NOTE: For compatibility, this looks up not only
" haskell-language-server-wrapper's user config but also
" haskell-language-server's one.
augroup vim_lsp_settings_haskell_language_server_wrapper
  au!
  LspRegisterServer {
      \ 'name': 'haskell-language-server',
      \ 'cmd': {server_info->
      \     lsp_settings#get('haskell-language-server-wrapper', 'cmd',
      \     lsp_settings#get('haskell-language-server', 'cmd',
      \     [lsp_settings#exec_path('haskell-language-server-wrapper')]+
      \         lsp_settings#get('haskell-language-server-wrapper', 'args',
      \         lsp_settings#get('haskell-language-server', 'args',
      \         ['--lsp']))))},
      \ 'root_uri': {server_info->
      \     lsp_settings#get('haskell-language-server-wrapper', 'root_uri',
      \     lsp_settings#get('haskell-language-server', 'root_uri',
      \     lsp_settings#get('haskell-language-server-wrapper', 'root_uri_patterns',
      \     lsp_settings#root_uri('haskell-language-server'))))},
      \ 'initialization_options':
      \     lsp_settings#get('haskell-language-server-wrapper', 'initialization_options',
      \     lsp_settings#get('haskell-language-server', 'initialization_options',
      \     v:null)),
      \ 'allowlist':
      \     lsp_settings#get('haskell-language-server-wrapper', 'allowlist',
      \     lsp_settings#get('haskell-language-server', 'allowlist',
      \     ['haskell', 'lhaskell'])),
      \ 'blocklist':
      \     lsp_settings#get('haskell-language-server-wrapper', 'blocklist',
      \     lsp_settings#get('haskell-language-server', 'blocklist',
      \     [])),
      \ 'config':
      \     lsp_settings#get('haskell-language-server-wrapper', 'config',
      \     lsp_settings#get('haskell-language-server', 'config',
      \     lsp_settings#server_config('haskell-language-server-wrapper'))),
      \ 'workspace_config':
      \     lsp_settings#get('haskell-language-server-wrapper', 'workspace_config',
      \     lsp_settings#get('haskell-language-server', 'workspace_config',
      \     {})),
      \ 'semantic_highlight':
      \     lsp_settings#get('haskell-language-server-wrapper', 'semantic_highlight',
      \     lsp_settings#get('haskell-language-server', 'semantic_highlight',
      \     {})),
      \ }
augroup END
