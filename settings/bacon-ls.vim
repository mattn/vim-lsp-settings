augroup vim_lsp_settings_bacon_ls
  au!
  LspRegisterServer {
      \ 'name': 'bacon-ls',
      \ 'cmd': {server_info->lsp_settings#get('bacon-ls', 'cmd', [lsp_settings#exec_path('bacon-ls')]+lsp_settings#get('bacon-ls', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('bacon-ls', 'root_uri', lsp_settings#root_uri('bacon-ls'))},
      \ 'initialization_options': lsp_settings#get('bacon-ls', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('bacon-ls', 'allowlist', ['rust']),
      \ 'blocklist': lsp_settings#get('bacon-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('bacon-ls', 'config', lsp_settings#server_config('bacon-ls')),
      \ 'workspace_config': lsp_settings#get('bacon-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('bacon-ls', 'semantic_highlight', {}),
      \ }
augroup END
