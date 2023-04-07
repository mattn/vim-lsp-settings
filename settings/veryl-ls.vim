augroup vim_lsp_settings_veryl_ls
  au!
  LspRegisterServer {
      \ 'name': 'veryl-ls',
      \ 'cmd': {server_info->lsp_settings#get('veryl-ls', 'cmd', [lsp_settings#exec_path('veryl-ls')]+lsp_settings#get('veryl-ls', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('veryl-ls', 'root_uri', lsp_settings#root_uri('veryl-ls'))},
      \ 'initialization_options': lsp_settings#get('veryl-ls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('veryl-ls', 'allowlist', ['veryl']),
      \ 'blocklist': lsp_settings#get('veryl-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('veryl-ls', 'config', lsp_settings#server_config('veryl-ls')),
      \ 'workspace_config': lsp_settings#get('veryl-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('veryl-ls', 'semantic_highlight', {}),
      \ }
augroup END
