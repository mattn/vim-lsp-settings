augroup vimlsp_settings_rust-analyzer
  au!
  LspRegisterServer {
      \ 'name': 'rust-analyzer',
      \ 'cmd': {server_info->lsp_settings#get('rust-analyzer', 'cmd', [lsp_settings#exec_path('rust-analyzer')])},
      \ 'root_uri':{server_info->lsp_settings#get('rust-analyzer', 'root_uri', lsp_settings#root_uri('rust-analyzer'))},
      \ 'initialization_options': lsp_settings#get('rust-analyzer', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('rust-analyzer', 'whitelist', ['rust']),
      \ 'blacklist': lsp_settings#get('rust-analyzer', 'blacklist', []),
      \ 'config': lsp_settings#get('rust-analyzer', 'config', lsp_settings#server_config('rust-analyzer')),
      \ 'workspace_config': lsp_settings#get('rust-analyzer', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('rust-analyzer', 'semantic_highlight', {}),
      \ }
augroup END
