augroup vim_lsp_settings_kakehashi
  au!
  LspRegisterServer {
      \ 'name': 'kakehashi',
      \ 'cmd': {server_info->lsp_settings#get('kakehashi', 'cmd', [lsp_settings#exec_path('kakehashi')]+lsp_settings#get('kakehashi', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('kakehashi', 'root_uri', lsp_settings#root_uri('kakehashi'))},
      \ 'initialization_options': lsp_settings#get('kakehashi', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('kakehashi', 'allowlist', ['*']),
      \ 'blocklist': lsp_settings#get('kakehashi', 'blocklist', []),
      \ 'config': lsp_settings#get('kakehashi', 'config', lsp_settings#server_config('kakehashi')),
      \ 'workspace_config': lsp_settings#get('kakehashi', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('kakehashi', 'semantic_highlight', {}),
      \ }
augroup END
