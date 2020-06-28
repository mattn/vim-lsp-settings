augroup vim_lsp_settings_rls
  au!
  LspRegisterServer {
      \ 'name': 'rls',
      \ 'cmd': {server_info->lsp_settings#get('rls', 'cmd', [lsp_settings#exec_path('rls')])},
      \ 'root_uri':{server_info->lsp_settings#get('rls', 'root_uri', lsp_settings#root_uri('rls'))},
      \ 'initialization_options': lsp_settings#get('rls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('rls', 'allowlist', ['rust']),
      \ 'blocklist': lsp_settings#get('rls', 'blocklist', []),
      \ 'config': lsp_settings#get('rls', 'config', lsp_settings#server_config('rls')),
      \ 'workspace_config': lsp_settings#get('rls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rls', 'semantic_highlight', {}),
      \ }
augroup END
