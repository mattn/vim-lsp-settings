augroup vim_lsp_settings_hyuga
  au!
  LspRegisterServer {
      \ 'name': 'fennel-ls',
      \ 'cmd': {server_info->lsp_settings#get('fennel-ls', 'cmd', [lsp_settings#exec_path('fennel-ls')]+lsp_settings#get('fennel-ls', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('fennel-ls', 'root_uri', lsp_settings#root_uri('fennel-ls'))},
      \ 'initialization_options': lsp_settings#get('fennel-ls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('fennel-ls', 'allowlist', ['fennel']),
      \ 'blocklist': lsp_settings#get('fennel-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('fennel-ls', 'config', lsp_settings#server_config('fennel-ls')),
      \ 'workspace_config': lsp_settings#get('fennel-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('fennel-ls', 'semantic_highlight', {}),
      \ }
augroup END
