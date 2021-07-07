augroup vim_lsp_settings_zeta_note
  au!
  LspRegisterServer {
      \ 'name': 'zeta-note',
      \ 'cmd': {server_info->lsp_settings#get('zeta-note', 'cmd', [lsp_settings#exec_path('zeta-note'), 'serve'])},
      \ 'root_uri':{server_info->lsp_settings#get('zeta-note', 'root_uri', lsp_settings#root_uri('zeta-note'))},
      \ 'initialization_options': lsp_settings#get('zeta-note', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('zeta-note', 'allowlist', ['markdown']),
      \ 'blocklist': lsp_settings#get('zeta-note', 'blocklist', []),
      \ 'config': lsp_settings#get('zeta-note', 'config', lsp_settings#server_config('zeta-note')),
      \ 'workspace_config': lsp_settings#get('zeta-note', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('zeta-note', 'semantic_highlight', {}),
      \ }
augroup END
