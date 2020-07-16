augroup vim_lsp_settings_pyls_all
  au!
  LspRegisterServer {
      \ 'name': 'pyls-all',
      \ 'cmd': {server_info->lsp_settings#get('pyls-all', 'cmd', [lsp_settings#exec_path('pyls-all')])},
      \ 'root_uri':{server_info->lsp_settings#get('pyls-all', 'root_uri', lsp_settings#root_uri('pyls-all'))},
      \ 'initialization_options': lsp_settings#get('pyls-all', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('pyls-all', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pyls-all', 'blocklist', []),
      \ 'config': lsp_settings#get('pyls-all', 'config', lsp_settings#server_config('pyls-all')),
      \ 'workspace_config': lsp_settings#get('pyls-all', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('pyls-all', 'semantic_highlight', {}),
      \ }
augroup END
