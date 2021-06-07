augroup vim_lsp_settings_pylsp_all
  au!
  LspRegisterServer {
      \ 'name': 'pylsp-all',
      \ 'cmd': {server_info->lsp_settings#get('pylsp-all', 'cmd', [lsp_settings#exec_path('pylsp-all')])},
      \ 'root_uri':{server_info->lsp_settings#get('pylsp-all', 'root_uri', lsp_settings#root_uri('pylsp-all'))},
      \ 'initialization_options': lsp_settings#get('pylsp-all', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('pylsp-all', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pylsp-all', 'blocklist', []),
      \ 'config': lsp_settings#get('pylsp-all', 'config', lsp_settings#server_config('pylsp-all')),
      \ 'workspace_config': lsp_settings#get('pylsp-all', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('pylsp-all', 'semantic_highlight', {}),
      \ }
augroup END
