augroup vim_lsp_settings_reason_language_server
  au!
  LspRegisterServer {
      \ 'name': 'reason-language-server',
      \ 'cmd': {server_info->lsp_settings#get('reason-language-server', 'cmd', [lsp_settings#exec_path('reason-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('reason-language-server', 'root_uri', lsp_settings#root_uri('reason-language-server'))},
      \ 'initialization_options': lsp_settings#get('reason-language-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('reason-language-server', 'allowlist', ['reason']),
      \ 'blocklist': lsp_settings#get('reason-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('reason-language-server', 'config', lsp_settings#server_config('reason-language-server')),
      \ 'workspace_config': lsp_settings#get('reason-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('reason-language-server', 'semantic_highlight', {}),
      \ }
augroup END
