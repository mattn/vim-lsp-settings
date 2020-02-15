augroup vimlsp_settings_javascript_typescript_stdio
  au!
  LspRegisterServer {
      \ 'name': 'javascript-typescript-stdio',
      \ 'cmd': {server_info->lsp_settings#get('javascript-typescript-stdio', 'cmd', [lsp_settings#exec_path('javascript-typescript-stdio')])},
      \ 'root_uri':{server_info->lsp_settings#get('javascript-typescript-stdio', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('javascript-typescript-stdio', 'initialization_options', {'diagnostics': 'true'}),
      \ 'whitelist': lsp_settings#get('javascript-typescript-stdio', 'whitelist', ['javascript', 'javascriptreact', 'javascript.jsx']),
      \ 'blacklist': lsp_settings#get('javascript-typescript-stdio', 'blacklist', []),
      \ 'config': lsp_settings#get('javascript-typescript-stdio', 'config', lsp_settings#server_config('javascript-typescript-stdio')),
      \ 'workspace_config': lsp_settings#get('javascript-typescript-stdio', 'workspace_config', {}),
      \ }
augroup END
