augroup vim_lsp_settings_sorbet
  au!
  LspRegisterServer {
      \ 'name': 'sorbet',
      \ 'cmd': {server_info->lsp_settings#get('sorbet', 'cmd', [lsp_settings#exec_path('sorbet'), lsp#utils#uri_to_path(lsp_settings#root_uri('sorbet')), '--lsp'])+lsp_settings#get('sorbet', 'args', [])},
      \ 'root_uri':{server_info->lsp_settings#get('sorbet', 'root_uri', lsp_settings#root_uri('sorbet'))},
      \ 'initialization_options': lsp_settings#get('sorbet', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('sorbet', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('sorbet', 'blocklist', []),
      \ 'config': lsp_settings#get('sorbet', 'config', lsp_settings#server_config('sorbet')),
      \ 'workspace_config': lsp_settings#get('sorbet', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('sorbet', 'semantic_highlight', {}),
      \ }
augroup END
