augroup vim_lsp_settings_fortls
  au!
  LspRegisterServer {
      \ 'name': 'fortls',
      \ 'cmd': {server_info->lsp_settings#get('fortls', 'cmd', [lsp_settings#exec_path('fortls')])},
      \ 'root_uri':{server_info->lsp_settings#get('fortls', 'root_uri', lsp_settings#root_uri('fortls'))},
      \ 'initialization_options': lsp_settings#get('fortls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('fortls', 'allowlist', ['fortran']),
      \ 'blocklist': lsp_settings#get('fortls', 'blocklist', []),
      \ 'config': lsp_settings#get('fortls', 'config', lsp_settings#server_config('fortls')),
      \ 'workspace_config': lsp_settings#get('fortls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('fortls', 'semantic_highlight', {}),
      \ }
augroup END
