augroup vim_lsp_settings_fsharp_language_server
  au!
  LspRegisterServer {
      \ 'name': 'fsharp-language-server',
      \ 'cmd': {server_info->lsp_settings#get('fsharp-language-server', 'cmd', [lsp_settings#exec_path('fsharp-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('fsharp-language-server', 'root_uri', lsp_settings#root_uri('fsharp-language-server'))},
      \ 'initialization_options': lsp_settings#get('fsharp-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('fsharp-language-server', 'allowlist', ['fsharp']),
      \ 'blocklist': lsp_settings#get('fsharp-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('fsharp-language-server', 'config', lsp_settings#server_config('fsharp-language-server')),
      \ 'workspace_config': lsp_settings#get('fsharp-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('fsharp-language-server', 'semantic_highlight', {}),
      \ }
augroup END
