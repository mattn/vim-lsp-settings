augroup vim_lsp_settings_vlang_vls
  au!
  LspRegisterServer {
      \ 'name': 'vlang-vls',
      \ 'cmd': {server_info->lsp_settings#get('vlang-vls', 'cmd', [lsp_settings#exec_path('vlang-vls')])},
      \ 'root_uri':{server_info->lsp_settings#get('vlang-vls', 'root_uri', lsp_settings#root_uri('vlang-vls'))},
      \ 'initialization_options': lsp_settings#get('vlang-vls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('vlang-vls', 'allowlist', ['vlang']),
      \ 'blocklist': lsp_settings#get('vlang-vls', 'blocklist', []),
      \ 'config': lsp_settings#get('vlang-vls', 'config', lsp_settings#server_config('vlang-vls')),
      \ 'workspace_config': lsp_settings#get('vlang-vls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('vlang-vls', 'semantic_highlight', {}),
      \ }
augroup END
