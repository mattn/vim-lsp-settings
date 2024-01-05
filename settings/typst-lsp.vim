augroup vim_lsp_settings_typst_lsp
  au!
  LspRegisterServer {
      \ 'name': 'typst-lsp',
      \ 'cmd': {server_info->lsp_settings#get('typst-lsp', 'cmd', [lsp_settings#exec_path('typst-lsp')]+lsp_settings#get('typst-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('typst-lsp', 'root_uri', lsp_settings#root_uri('typst-lsp'))},
      \ 'initialization_options': lsp_settings#get('typst-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('typst-lsp', 'allowlist', ['typst', 'typ']),
      \ 'blocklist': lsp_settings#get('typst-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('typst-lsp', 'config', lsp_settings#server_config('typst-lsp')),
      \ 'workspace_config': lsp_settings#get('typst-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('typst-lsp', 'semantic_highlight', {}),
      \ }
augroup END
