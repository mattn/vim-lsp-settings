augroup vim_lsp_settings_prolog_lsp_server
  au!
  LspRegisterServer {
      \ 'name': 'prolog-lsp_server',
      \ 'cmd': {server_info->lsp_settings#get('prolog-lsp_server', 'cmd', [lsp_settings#exec_path('prolog-lsp_server')])},
      \ 'root_uri':{server_info->lsp_settings#get('prolog-lsp_server', 'root_uri', lsp_settings#root_uri('prolog-lsp_server'))},
      \ 'initialization_options': lsp_settings#get('prolog-lsp_server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('prolog-lsp_server', 'allowlist', ['prolog']),
      \ 'blocklist': lsp_settings#get('prolog-lsp_server', 'blocklist', []),
      \ 'config': lsp_settings#get('prolog-lsp_server', 'config', lsp_settings#server_config('prolog-lsp_server')),
      \ 'workspace_config': lsp_settings#get('prolog-lsp_server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('prolog-lsp_server', 'semantic_highlight', {}),
      \ }
augroup END
