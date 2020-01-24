augroup vimlsp_settings_typescript_language_server
  au!
  LspRegisterServer {
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->lsp_settings#get('typescript-language-server', 'cmd', [lsp_settings#exec_path('typescript-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('typescript-language-server', 'root_uri', lsp_settings#root_uri(extend(['package.json', 'tsconfig.json'], g:lsp_settings_root_markers)))},
      \ 'initialization_options': lsp_settings#get('typescript-language-server', 'initialization_options', {"diagnostics": "true"}),
      \ 'whitelist': lsp_settings#get('typescript-language-server', 'whitelist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact']),
      \ 'blacklist': lsp_settings#get('typescript-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('typescript-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('typescript-language-server', 'workspace_config', {}),
      \ }
augroup END
