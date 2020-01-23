augroup vimlsp_settings_fortls
  au!
  LspRegisterServer {
      \ 'name': 'fortls',
      \ 'cmd': {server_info->lsp_settings#get('fortls', 'cmd', [lsp_settings#exec_path('fortls')])},
      \ 'root_uri':{server_info->lsp_settings#get('fortls', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('fortls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('fortls', 'whitelist', ['fortran']),
      \ 'blacklist': lsp_settings#get('fortls', 'blacklist', []),
      \ 'config': lsp_settings#get('fortls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('fortls', 'workspace_config', {}),
      \ }
augroup END
