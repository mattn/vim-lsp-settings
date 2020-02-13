augroup vimlsp_settings_r_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'r-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('r-languageserver', 'cmd', ['R', '--slave', '-e', 'languageserver::run()'])},
      \ 'root_uri':{server_info->lsp_settings#get('r-languageserver', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('r-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('r-languageserver', 'whitelist', ['r']),
      \ 'blacklist': lsp_settings#get('r-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('r-languageserver', 'config', lsp_settings#server_config('r-languageserver')),
      \ 'workspace_config': lsp_settings#get('r-languageserver', 'workspace_config', {}),
      \ }
augroup END

