augroup vim_lsp_settings_clj_kondo_lsp
  au!
  LspRegisterServer {
      \ 'name': 'clj-kondo-lsp',
      \ 'cmd': {server_info->lsp_settings#get('clj-kondo-lsp', 'cmd', ['java', '-jar', lsp_settings#exec_path('clj-kondo-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('clj-kondo-lsp', 'root_uri', lsp_settings#root_uri('clj-kondo-lsp'))},
      \ 'initialization_options': lsp_settings#get('clj-kondo-lsp', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('clj-kondo-lsp', 'allowlist', ['clojure']),
      \ 'blocklist': lsp_settings#get('clj-kondo-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('clj-kondo-lsp', 'config', lsp_settings#server_config('clj-kondo-lsp')),
      \ 'workspace_config': lsp_settings#get('clj-kondo-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('clj-kondo-lsp', 'semantic_highlight', {}),
      \ }
augroup END
