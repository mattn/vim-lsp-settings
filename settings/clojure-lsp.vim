augroup vimlsp_settings_clojure_lsp
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'clojure-lsp',
      \ 'cmd': {server_info->lsp_settings#get('clojure-lsp', 'cmd', [lsp_settings#exec_path('clojure-lsp')])},
      \ 'initialization_options': lsp_settings#get('clojure-lsp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('clojure-lsp', 'whitelist', ['clojure']),
      \ 'blacklist': lsp_settings#get('clojure-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('clojure-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('clojure-lsp', 'workspace_config', {}),
      \ })
augroup END
