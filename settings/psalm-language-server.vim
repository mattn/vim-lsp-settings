augroup vim_lsp_settings_psalm_language_server
  au!
  LspRegisterServer {
      \ 'name': 'psalm-language-server',
      \ 'cmd': {server_info->lsp_settings#get('psalm-language-server', 'cmd', [lsp_settings#exec_path('psalm-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('psalm-language-server', 'root_uri', lsp_settings#root_uri('psalm-language-server'))},
      \ 'initialization_options': lsp_settings#get('psalm-language-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('psalm-language-server', 'allowlist', ['php']),
      \ 'blocklist': lsp_settings#get('psalm-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('psalm-language-server', 'config', lsp_settings#server_config('psalm-language-server')),
      \ 'workspace_config': lsp_settings#get('psalm-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('psalm-language-server', 'semantic_highlight', {}),
      \ }
augroup END
