augroup vim_lsp_settings_omnisharp_lsp
  au!
  LspRegisterServer {
      \ 'name': 'omnisharp-lsp',
      \ 'cmd': {server_info->lsp_settings#get('omnisharp-lsp', 'cmd', [lsp_settings#exec_path('omnisharp-lsp'), '-lsp'])},
      \ 'root_uri':{server_info->lsp_settings#get('omnisharp-lsp', 'root_uri', lsp_settings#root_uri('omnisharp-lsp'))},
      \ 'initialization_options': lsp_settings#get('omnisharp-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('omnisharp-lsp', 'allowlist', ['cs']),
      \ 'blocklist': lsp_settings#get('omnisharp-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('omnisharp-lsp', 'config', lsp_settings#server_config('omnisharp-lsp')),
      \ 'workspace_config': lsp_settings#get('omnisharp-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('omnisharp-lsp', 'semantic_highlight', {}),
      \ }
augroup END
