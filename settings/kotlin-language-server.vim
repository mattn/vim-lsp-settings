augroup vim_lsp_settings_kotlin_language_server
  au!
  LspRegisterServer {
      \ 'name': 'kotlin-language-server',
      \ 'cmd': {server_info->lsp_settings#get('kotlin-language-server', 'cmd', [lsp_settings#exec_path('kotlin-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('kotlin-language-server', 'root_uri', lsp_settings#root_uri('kotlin-language-server'))},
      \ 'initialization_options': lsp_settings#get('kotlin-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('kotlin-language-server', 'allowlist', ['kotlin']),
      \ 'blocklist': lsp_settings#get('kotlin-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('kotlin-language-server', 'config', lsp_settings#server_config('kotlin-language-server')),
      \ 'workspace_config': lsp_settings#get('kotlin-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('kotlin-language-server', 'semantic_highlight', {}),
      \ }
augroup END
