augroup vim_lsp_settings_esbonio
  au!
  LspRegisterServer {
      \ 'name': 'esbonio',
      \ 'cmd': {server_info->lsp_settings#get('esbonio', 'cmd', [lsp_settings#exec_path('esbonio')])},
      \ 'root_uri':{server_info->lsp_settings#get('esbonio', 'root_uri', lsp_settings#root_uri('esbonio'))},
      \ 'initialization_options': lsp_settings#get('esbonio', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('esbonio', 'allowlist', ['rst']),
      \ 'blocklist': lsp_settings#get('esbonio', 'blocklist', []),
      \ 'config': lsp_settings#get('esbonio', 'config', lsp_settings#server_config('esbonio')),
      \ 'workspace_config': lsp_settings#get('esbonio', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('esbonio', 'semantic_highlight', {}),
      \ }
augroup END
