augroup vim_lsp_settings_pyls
  au!
  LspRegisterServer {
      \ 'name': 'pyls',
      \ 'cmd': {server_info->lsp_settings#get('pyls', 'cmd', [lsp_settings#exec_path('pyls')])},
      \ 'root_uri':{server_info->lsp_settings#get('pyls', 'root_uri', lsp_settings#root_uri('pyls'))},
      \ 'initialization_options': lsp_settings#get('pyls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('pyls', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pyls', 'blocklist', []),
      \ 'config': lsp_settings#get('pyls', 'config', lsp_settings#server_config('pyls')),
      \ 'workspace_config': lsp_settings#get('pyls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('pyls', 'semantic_highlight', {}),
      \ }
augroup END
