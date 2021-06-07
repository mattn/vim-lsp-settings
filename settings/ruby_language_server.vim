augroup vim_lsp_settings_ruby_language_server
  au!
  LspRegisterServer {
      \ 'name': 'ruby_language_server',
      \ 'cmd': {server_info->lsp_settings#get('ruby_language_server', 'cmd', [lsp_settings#exec_path('ruby_language_server')])},
      \ 'root_uri':{server_info->lsp_settings#get('ruby_language_server', 'root_uri', lsp_settings#root_uri('ruby_language_server'))},
      \ 'initialization_options': lsp_settings#get('ruby_language_server', 'initialization_options', {'diagnostics': 'false'}),
      \ 'allowlist': lsp_settings#get('ruby_language_server', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('ruby_language_server', 'blocklist', []),
      \ 'config': lsp_settings#get('ruby_language_server', 'config', lsp_settings#server_config('ruby_language_server')),
      \ 'workspace_config': lsp_settings#get('ruby_language_server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ruby_language_server', 'semantic_highlight', {}),
      \ }
augroup END
