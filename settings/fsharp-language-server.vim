augroup vimlsp_settings_fsharp_language_server
  au!
  LspRegisterServer {
      \ 'name': 'fsharp-language-server',
      \ 'cmd': {server_info->lsp_settings#get('fsharp-language-server', 'cmd', [lsp_settings#exec_path('fsharp-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('fsharp-language-server', 'root_uri', lsp_settings#root_uri('fsharp-language-server'))},
      \ 'initialization_options': lsp_settings#get('fsharp-language-server', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('fsharp-language-server', 'whitelist', ['fsharp']),
      \ 'blacklist': lsp_settings#get('fsharp-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('fsharp-language-server', 'config', lsp_settings#server_config('fsharp-language-server')),
      \ 'workspace_config': lsp_settings#get('fsharp-language-server', 'workspace_config', {}),
      \ }
augroup END
