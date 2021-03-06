augroup vim_lsp_settings_racket_lsp
  au!
  LspRegisterServer {
      \ 'name': 'racket-lsp',
      \ 'cmd': {server_info->lsp_settings#get('racket-lsp', 'cmd', [lsp_settings#exec_path('racket-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('racket-lsp', 'root_uri', lsp_settings#root_uri('racket-lsp'))},
      \ 'initialization_options': lsp_settings#get('racket-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('racket-lsp', 'allowlist', ['racket']),
      \ 'blocklist': lsp_settings#get('racket-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('racket-lsp', 'config', lsp_settings#server_config('racket-lsp')),
      \ 'workspace_config': lsp_settings#get('racket-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('racket-lsp', 'semantic_highlight', {}),
      \ }
augroup END
