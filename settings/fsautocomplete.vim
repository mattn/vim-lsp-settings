augroup vim_lsp_settings_fsautocomplete
  au!
  LspRegisterServer {
      \ 'name': 'fsautocomplete',
      \ 'cmd': {server_info->lsp_settings#get('fsautocomplete', 'cmd', [lsp_settings#exec_path('fsautocomplete'), '--background-service-enabled'])},
      \ 'root_uri':{server_info->lsp_settings#get('fsautocomplete', 'root_uri', lsp_settings#root_uri('fsautocomplete'))},
      \ 'initialization_options': lsp_settings#get('fsautocomplete', 'initialization_options', {'AutomaticWorkspaceInit': v:true}),
      \ 'allowlist': lsp_settings#get('fsautocomplete', 'allowlist', ['fsharp']),
      \ 'blocklist': lsp_settings#get('fsautocomplete', 'blocklist', []),
      \ 'config': lsp_settings#get('fsautocomplete', 'config', lsp_settings#server_config('fsautocomplete')),
      \ 'workspace_config': lsp_settings#get('fsautocomplete', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('fsautocomplete', 'semantic_highlight', {}),
      \ }
augroup END
