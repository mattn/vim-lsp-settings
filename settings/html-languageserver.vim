augroup vim_lsp_settings_html_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'html-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('html-languageserver', 'cmd', [lsp_settings#exec_path('html-languageserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('html-langserver', 'root_uri', lsp_settings#root_uri('html-languageserver'))},
      \ 'initialization_options': lsp_settings#get('html-languageserver', 'initialization_options', {'embeddedLanguages': {'css': v:true, 'javascript': v:true}}),
      \ 'allowlist': lsp_settings#get('html-languageserver', 'allowlist', ['html']),
      \ 'blocklist': lsp_settings#get('html-languageserver', 'blocklist', []),
      \ 'config': lsp_settings#get('html-languageserver', 'config', lsp_settings#server_config('html-languageserver')),
      \ 'workspace_config': lsp_settings#get('html-languageserver', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('html-languageserver', 'semantic_highlight', {}),
      \ }
augroup END
