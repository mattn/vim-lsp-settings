augroup vim_lsp_settings_nil
  au!
  LspRegisterServer {
      \ 'name': 'nil',
      \ 'cmd': {server_info->lsp_settings#get('nil', 'cmd', lsp_settings#exec_path('nil'))},
      \ 'root_uri':{server_info->lsp_settings#get('nil', 'root_uri', lsp_settings#root_uri('nil'))},
      \ 'initialization_options': lsp_settings#get('nil', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('nil', 'allowlist', ['nix']),
      \ 'blocklist': lsp_settings#get('nil', 'blocklist', []),
      \ 'config': lsp_settings#get('nil', 'config', lsp_settings#server_config('nil')),
      \ 'workspace_config': lsp_settings#get('nil', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('nil', 'semantic_highlight', {}),
      \ }
augroup END
