augroup vim_lsp_settings_rnix_lsp
  au!
  LspRegisterServer {
      \ 'name': 'rnix-lsp',
      \ 'cmd': {server_info->lsp_settings#get('rnix-lsp', 'cmd', lsp_settings#exec_path('rnix-lsp'))},
      \ 'root_uri':{server_info->lsp_settings#get('rnix-lsp', 'root_uri', lsp_settings#root_uri('rnix-lsp'))},
      \ 'initialization_options': lsp_settings#get('rnix-lsp', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('rnix-lsp', 'allowlist', ['nix']),
      \ 'blocklist': lsp_settings#get('rnix-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('rnix-lsp', 'config', lsp_settings#server_config('rnix-lsp')),
      \ 'workspace_config': lsp_settings#get('rnix-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rnix-lsp', 'semantic_highlight', {}),
      \ }
augroup END
