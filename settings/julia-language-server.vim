augroup vim_lsp_settings_julia_language_server
  au!
  LspRegisterServer {
      \ 'name': 'julia-language-server',
      \ 'cmd': {server_info->lsp_settings#get('julia-language-server', 'cmd', [lsp_settings#exec_path('julia-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('julia-language-server', 'root_uri', lsp_settings#root_uri('julia-language-server'))},
      \ 'initialization_options': lsp_settings#get('julia-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('julia-language-server', 'allowlist', ['julia']),
      \ 'blocklist': lsp_settings#get('julia-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('julia-language-server', 'config', lsp_settings#server_config('julia-language-server')),
      \ 'workspace_config': lsp_settings#get('julia-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('julia-language-server', 'semantic_highlight', {}),
      \ }
augroup END
