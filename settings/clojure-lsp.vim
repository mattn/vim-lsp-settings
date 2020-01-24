augroup vimlsp_settings_clojure_lsp
  au!
  LspRegisterServer {
      \ 'name': 'clojure-lsp',
      \ 'cmd': {server_info->lsp_settings#get('clojure-lsp', 'cmd', [lsp_settings#exec_path('clojure-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('clojure-lsp', 'root_uri', lsp_settings#root_uri(extend([
      \     '.lein/', '.shadow-cljs/', 'project.clj', 'deps.edn', 'shadow-cljs.edn'], g:lsp_settings_root_markers)))},
      \ 'initialization_options': lsp_settings#get('clojure-lsp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('clojure-lsp', 'whitelist', ['clojure']),
      \ 'blacklist': lsp_settings#get('clojure-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('clojure-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('clojure-lsp', 'workspace_config', {}),
      \ }
augroup END
