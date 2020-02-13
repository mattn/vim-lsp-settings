augroup vimlsp_settings_fsautocomplete
  au!
  LspRegisterServer {
      \ 'name': 'fsautocomplete',
      \ 'cmd': {server_info->lsp_settings#get('fsautocomplete', 'cmd', [lsp_settings#exec_path('fsautocomplete'), '--background-service-enabled'])},
      \ 'root_uri':{server_info->lsp_settings#get('fsautocomplete', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('fsautocomplete', 'initialization_options', {'AutomaticWorkspaceInit': v:true}),
      \ 'whitelist': lsp_settings#get('fsautocomplete', 'whitelist', ['fsharp']),
      \ 'blacklist': lsp_settings#get('fsautocomplete', 'blacklist', []),
      \ 'config': lsp_settings#get('fsautocomplete', 'config', lsp_settings#server_config('fsautocomplete')),
      \ 'workspace_config': lsp_settings#get('fsautocomplete', 'workspace_config', {}),
      \ }
augroup END
