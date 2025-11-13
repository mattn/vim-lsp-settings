augroup vim_lsp_settings_moonbit_lsp
  au!
  LspRegisterServer {
      \ 'name': 'moonbit-lsp',
      \ 'cmd': {server_info->lsp_settings#get('moonbit-lsp', 'cmd', [lsp_settings#exec_path('moonbit-lsp')]+lsp_settings#get('moonbit-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('moonbit-lsp', 'root_uri', lsp_settings#root_uri('moonbit-lsp'))},
      \ 'initialization_options': lsp_settings#get('moonbit-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('moonbit-lsp', 'allowlist', ['moonbit']),
      \ 'blocklist': lsp_settings#get('moonbit-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('moonbit-lsp', 'config', lsp_settings#server_config('moonbit-lsp')),
      \ 'workspace_config': lsp_settings#get('moonbit-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('moonbit-lsp', 'semantic_highlight', {}),
      \ }
augroup END
