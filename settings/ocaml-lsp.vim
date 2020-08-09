augroup vim_lsp_settings_ocaml_lsp
  au!
  LspRegisterServer {
      \ 'name': 'ocaml-lsp',
      \ 'cmd': {server_info->lsp_settings#get('ocaml-lsp', 'cmd', [lsp_settings#exec_path('ocaml-lsp'), '--log-file=log.txt'])},
      \ 'root_uri':{server_info->lsp_settings#get('ocaml-lsp', 'root_uri', lsp_settings#root_uri('ocaml-lsp'))},
      \ 'initialization_options': lsp_settings#get('ocaml-lsp', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('ocaml-lsp', 'allowlist', ['ocaml']),
      \ 'blocklist': lsp_settings#get('ocaml-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('ocaml-lsp', 'config', lsp_settings#server_config('ocaml-lsp')),
      \ 'workspace_config': lsp_settings#get('ocaml-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ocaml-lsp', 'semantic_highlight', {}),
      \ }
augroup END

