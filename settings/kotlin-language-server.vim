augroup vimlsp_settings_kotlin_language_server
  au!
  LspRegisterServer {
      \ 'name': 'kotlin-language-server',
      \ 'cmd': {server_info->lsp_settings#get('kotlin-language-server', 'cmd', [lsp_settings#exec_path('kotlin-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('kotlin-language-server', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('kotlin-language-server', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('kotlin-language-server', 'whitelist', ['kotlin']),
      \ 'blacklist': lsp_settings#get('kotlin-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('kotlin-language-server', 'config', lsp_settings#server_config('kotlin-language-server')),
      \ 'workspace_config': lsp_settings#get('kotlin-language-server', 'workspace_config', {}),
      \ }
augroup END
