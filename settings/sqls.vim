augroup vimlsp_settings_sqls
  au!
  LspRegisterServer {
      \ 'name': 'sqls',
      \ 'cmd': {server_info->lsp_settings#get('sqls', 'cmd', [lsp_settings#exec_path('sqls')])},
      \ 'root_uri':{server_info->lsp_settings#get('sqls', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('sqls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('sqls', 'whitelist', ['sql']),
      \ 'blacklist': lsp_settings#get('sqls', 'blacklist', []),
      \ 'config': lsp_settings#get('sqls', 'config', lsp_settings#server_config('sqls')),
      \ 'workspace_config': lsp_settings#get('sqls', 'workspace_config', {}),
      \ }
augroup END
