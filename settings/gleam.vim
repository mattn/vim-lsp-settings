augroup vim_lsp_settings_gleam
  au!
  LspRegisterServer {
      \ 'name': 'gleam',
      \ 'cmd': {server_info->lsp_settings#get('gleam', 'cmd', [lsp_settings#exec_path('gleam')]+lsp_settings#get('gleam', 'args', ['lsp']))},
      \ 'root_uri':{server_info->lsp_settings#get('gleam', 'root_uri', lsp_settings#root_uri('gleam'))},
      \ 'initialization_options': lsp_settings#get('gleam', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('gleam', 'allowlist', ['gleam']),
      \ 'blocklist': lsp_settings#get('gleam', 'blocklist', []),
      \ 'config': lsp_settings#get('gleam', 'config', lsp_settings#server_config('gleam')),
      \ 'workspace_config': lsp_settings#get('gleam', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('gleam', 'semantic_highlight', {}),
      \ }
augroup END
