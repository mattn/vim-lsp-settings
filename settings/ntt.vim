augroup vim_lsp_settings_ntt
  au!
  LspRegisterServer {
      \ 'name': 'ntt',
      \ 'cmd': {server_info->lsp_settings#get('ntt', 'cmd', [lsp_settings#exec_path('ntt'), 'langserver'])},
      \ 'root_uri':{server_info->lsp_settings#get('ntt', 'root_uri', lsp_settings#root_uri('ntt'))},
      \ 'initialization_options': lsp_settings#get('ntt', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('ntt', 'allowlist', ['ttcn3', 'ttcn']),
      \ 'blocklist': lsp_settings#get('ntt', 'blocklist', []),
      \ 'config': lsp_settings#get('ntt', 'config', lsp_settings#server_config('ntt')),
      \ 'workspace_config': lsp_settings#get('ntt', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ntt', 'semantic_highlight', {}),
      \ }
augroup END
