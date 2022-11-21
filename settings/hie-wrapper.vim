" NOTE: For compatibility, this looks up not only hie-wrapper's user config
" but also hie's one.
augroup vim_lsp_settings_hie_wrapper
  au!
  LspRegisterServer {
      \ 'name': 'hie',
      \ 'cmd': {server_info->
      \     lsp_settings#get('hie-wrapper', 'cmd',
      \     lsp_settings#get('hie', 'cmd',
      \     [lsp_settings#exec_path('hie-wrapper')]+
      \         lsp_settings#get('hie-wrapper', 'args',
      \         lsp_settings#get('hie', 'args',
      \         ['--lsp']))))},
      \ 'root_uri': {server_info->
      \     lsp_settings#get('hie-wrapper', 'root_uri',
      \     lsp_settings#get('hie', 'root_uri',
      \     lsp_settings#get('hie-wrapper', 'root_uri_patterns',
      \     lsp_settings#root_uri('hie'))))},
      \ 'initialization_options':
      \     lsp_settings#get('hie-wrapper', 'initialization_options',
      \     lsp_settings#get('hie', 'initialization_options',
      \     v:null)),
      \ 'allowlist':
      \     lsp_settings#get('hie-wrapper', 'allowlist',
      \     lsp_settings#get('hie', 'allowlist',
      \     ['haskell', 'lhaskell'])),
      \ 'blocklist':
      \     lsp_settings#get('hie-wrapper', 'blocklist',
      \     lsp_settings#get('hie', 'blocklist',
      \     [])),
      \ 'config':
      \     lsp_settings#get('hie-wrapper', 'config',
      \     lsp_settings#get('hie', 'config',
      \     lsp_settings#server_config('hie-wrapper'))),
      \ 'workspace_config':
      \     lsp_settings#get('hie-wrapper', 'workspace_config',
      \     lsp_settings#get('hie', 'workspace_config',
      \     {})),
      \ 'semantic_highlight':
      \     lsp_settings#get('hie-wrapper', 'semantic_highlight',
      \     lsp_settings#get('hie', 'semantic_highlight',
      \     {})),
      \ }
augroup END
