augroup vim_lsp_settings_pylsp
  au!
  LspRegisterServer {
      \ 'name': 'pylsp',
      \ 'cmd': {server_info->lsp_settings#get('pylsp', 'cmd', [lsp_settings#exec_path('pylsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('pylsp', 'root_uri', lsp_settings#root_uri('pylsp'))},
      \ 'initialization_options': lsp_settings#get('pylsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('pylsp', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pylsp', 'blocklist', []),
      \ 'config': lsp_settings#get('pylsp', 'config', lsp_settings#server_config('pylsp')),
      \ 'workspace_config': lsp_settings#get('pylsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('pylsp', 'semantic_highlight', {}),
      \ }
augroup END
