augroup vim_lsp_settings_apex_jorje_lsp
  au!
  LspRegisterServer {
      \ 'name': 'apex-jorje-lsp',
      \ 'cmd': {server_info->lsp_settings#get('apex-jorje-lsp', 'cmd', [lsp_settings#exec_path('apex-jorje-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('apex-jorje-lsp', 'root_uri', lsp_settings#root_uri('apex-jorje-lsp'))},
      \ 'initialization_options': lsp_settings#get('apex-jorje-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('apex-jorje-lsp', 'allowlist', ['apex']),
      \ 'blocklist': lsp_settings#get('apex-jorje-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('apex-jorje-lsp', 'config', lsp_settings#server_config('apex-jorje-lsp')),
      \ 'workspace_config': lsp_settings#get('apex-jorje-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('apex-jorje-lsp', 'semantic_highlight', {}),
      \ }
augroup END
