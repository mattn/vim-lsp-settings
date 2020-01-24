augroup vimlsp_settings_omnisharp_lsp
  au!
  LspRegisterServer {
      \ 'name': 'omnisharp-lsp',
      \ 'cmd': {server_info->lsp_settings#get('omnisharp-lsp', 'cmd', [lsp_settings#exec_path('omnisharp-lsp'), '-lsp'])},
      \ 'root_uri':{server_info->lsp_settings#get('omnisharp-lsp', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('omnisharp-lsp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('omnisharp-lsp', 'whitelist', ['cs']),
      \ 'blacklist': lsp_settings#get('omnisharp-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('omnisharp-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('omnisharp-lsp', 'workspace_config', {}),
      \ }
augroup END
