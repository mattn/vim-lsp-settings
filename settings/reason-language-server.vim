augroup vimlsp_settings_reason_language_server
  au!
  LspRegisterServer {
      \ 'name': 'reason-language-server',
      \ 'cmd': {server_info->lsp_settings#get('reason-language-server', 'cmd', [lsp_settings#exec_path('reason-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('reason-language-server', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('reason-language-server', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('reason-language-server', 'whitelist', ['reason']),
      \ 'blacklist': lsp_settings#get('reason-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('reason-language-server', 'config', lsp_settings#server_config('reason-language-server')),
      \ 'workspace_config': lsp_settings#get('reason-language-server', 'workspace_config', {}),
      \ }
augroup END
