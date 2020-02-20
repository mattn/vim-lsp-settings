augroup vimlsp_settings_groovy_language_server
  au!
  LspRegisterServer {
      \ 'name': 'groovy-language-server',
      \ 'cmd': {server_info->lsp_settings#get('groovy-language-server', 'cmd', [lsp_settings#exec_path('groovy-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('groovy-language-server', 'root_uri', lsp_settings#root_uri('groovy-language-server'))},
      \ 'initialization_options': lsp_settings#get('groovy-language-server', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('groovy-language-server', 'whitelist', ['groovy']),
      \ 'blacklist': lsp_settings#get('groovy-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('groovy-language-server', 'config', lsp_settings#server_config('groovy-language-server')),
      \ 'workspace_config': lsp_settings#get('groovy-language-server', 'workspace_config', {}),
      \ }
augroup END
