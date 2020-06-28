augroup vim_lsp_settings_clojure_lsp
  au!
  LspRegisterServer {
      \ 'name': 'clojure-lsp',
      \ 'cmd': {server_info->lsp_settings#get('clojure-lsp', 'cmd', [lsp_settings#exec_path('clojure-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('clojure-lsp', 'root_uri', lsp_settings#root_uri('clojure-lsp'))},
      \ 'initialization_options': lsp_settings#get('clojure-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('clojure-lsp', 'allowlist', ['clojure']),
      \ 'blocklist': lsp_settings#get('clojure-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('clojure-lsp', 'config', lsp_settings#server_config('clojure-lsp')),
      \ 'workspace_config': lsp_settings#get('clojure-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('clojure-lsp', 'semantic_highlight', {}),
      \ }
augroup END
