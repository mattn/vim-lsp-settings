augroup vimlsp_settings_powershell_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'powershell-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('powershell-languageserver', 'cmd', [lsp_settings#exec_path('powershell-languageserver')])},
      \ 'root_uri':{server_info->lsp_settings#get('powershell-languageserver', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('powershell-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('powershell-languageserver', 'whitelist', ['ps1']),
      \ 'blacklist': lsp_settings#get('powershell-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('solargraph', 'config', {}),
      \ 'workspace_config': lsp_settings#get('powershell-languageserver', 'workspace_config', {}),
      \ }
augroup END
