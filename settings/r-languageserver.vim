augroup vim_lsp_settings_r_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'r-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('r-languageserver', 'cmd', ['R', '--slave', '-e', 'languageserver::run()'])},
      \ 'root_uri':{server_info->lsp_settings#get('r-languageserver', 'root_uri', lsp_settings#root_uri('r-languageserver'))},
      \ 'initialization_options': lsp_settings#get('r-languageserver', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('r-languageserver', 'allowlist', ['r']),
      \ 'blocklist': lsp_settings#get('r-languageserver', 'blocklist', []),
      \ 'config': lsp_settings#get('r-languageserver', 'config', lsp_settings#server_config('r-languageserver')),
      \ 'workspace_config': lsp_settings#get('r-languageserver', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('r-languageserver', 'semantic_highlight', {}),
      \ }
augroup END

