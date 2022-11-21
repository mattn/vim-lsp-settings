augroup vim_lsp_settings_marksman
  au!
  LspRegisterServer {
      \ 'name': 'marksman',
      \ 'cmd': {server_info->lsp_settings#get('marksman', 'cmd', [lsp_settings#exec_path('marksman')]+lsp_settings#get('marksman', 'args', ['server']))},
      \ 'root_uri':{server_info->lsp_settings#get('marksman', 'root_uri', lsp_settings#root_uri('marksman'))},
      \ 'initialization_options': lsp_settings#get('marksman', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('marksman', 'allowlist', ['markdown']),
      \ 'blocklist': lsp_settings#get('marksman', 'blocklist', []),
      \ 'config': lsp_settings#get('marksman', 'config', lsp_settings#server_config('marksman')),
      \ 'workspace_config': lsp_settings#get('marksman', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('marksman', 'semantic_highlight', {}),
      \ }
augroup END
