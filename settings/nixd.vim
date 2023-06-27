augroup vim_lsp_settings_nixd
  au!
  LspRegisterServer {
      \ 'name': 'nixd',
      \ 'cmd': {server_info->lsp_settings#get('nixd', 'cmd', lsp_settings#exec_path('nixd'))},
      \ 'root_uri':{server_info->lsp_settings#get('nid', 'root_uri', lsp_settings#root_uri('nixd'))},
      \ 'initialization_options': lsp_settings#get('nixd', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('nixd', 'allowlist', ['nix']),
      \ 'blocklist': lsp_settings#get('nixd', 'blocklist', []),
      \ 'config': lsp_settings#get('nixd', 'config', lsp_settings#server_config('nixd')),
      \ 'workspace_config': lsp_settings#get('nixd', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('nixd', 'semantic_highlight', {}),
      \ }
augroup END
