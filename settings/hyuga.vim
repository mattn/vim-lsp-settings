augroup vim_lsp_settings_hyuga
  au!
  LspRegisterServer {
      \ 'name': 'hyuga',
      \ 'cmd': {server_info->lsp_settings#get('hyuga', 'cmd', [lsp_settings#exec_path('hyuga')]+lsp_settings#get('hyuga', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('hyuga', 'root_uri', lsp_settings#root_uri('hyuga'))},
      \ 'initialization_options': lsp_settings#get('hyuga', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('hyuga', 'allowlist', ['hy']),
      \ 'blocklist': lsp_settings#get('hyuga', 'blocklist', []),
      \ 'config': lsp_settings#get('hyuga', 'config', lsp_settings#server_config('hyuga')),
      \ 'workspace_config': lsp_settings#get('hyuga', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('hyuga', 'semantic_highlight', {}),
      \ }
augroup END
