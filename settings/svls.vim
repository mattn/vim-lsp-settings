augroup vim_lsp_settings_svls
  au!
  LspRegisterServer {
      \ 'name': 'svls',
      \ 'cmd': {server_info->lsp_settings#get('svls', 'cmd', [lsp_settings#exec_path('svls')])},
      \ 'root_uri':{server_info->lsp_settings#get('svls', 'root_uri', lsp_settings#root_uri('svls'))},
      \ 'initialization_options': lsp_settings#get('svls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('svls', 'allowlist', ['systemverilog']),
      \ 'blocklist': lsp_settings#get('svls', 'blocklist', []),
      \ 'config': lsp_settings#get('svls', 'config', lsp_settings#server_config('svls')),
      \ 'workspace_config': lsp_settings#get('svls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('svls', 'semantic_highlight', {}),
      \ }
augroup END
