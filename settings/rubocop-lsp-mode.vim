augroup vim_lsp_settings_rubocop_vim_ls
  au!
  LspRegisterServer {
      \ 'name': 'rubocop-lsp-mode',
      \ 'cmd': {server_info->lsp_settings#get('rubocop-lsp-mode', 'cmd', [lsp_settings#exec_path('rubocop-lsp-mode'), lsp#utils#uri_to_path(lsp_settings#root_uri('rubocop-lsp-mode')), '--lsp'])+lsp_settings#get('rubocop-lsp-mode', 'args', [])},
      \ 'root_uri':{server_info->lsp_settings#get('rubocop-lsp-mode', 'root_uri', lsp_settings#root_uri('rubocop-lsp-mode'))},
      \ 'initialization_options': lsp_settings#get('rubocop-lsp-mode', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('rubocop-lsp-mode', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('rubocop-lsp-mode', 'blocklist', []),
      \ 'config': lsp_settings#get('rubocop-lsp-mode', 'config', lsp_settings#server_config('rubocop-lsp-mode')),
      \ 'workspace_config': lsp_settings#get('rubocop-lsp-mode', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rubocop-lsp-mode', 'semantic_highlight', {}),
      \ }
augroup END
