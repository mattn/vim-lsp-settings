augroup vim_lsp_settings_daggerlsp
  au!
  LspRegisterServer {
      \ 'name': 'daggerlsp',
      \ 'cmd': {server_info->lsp_settings#get('daggerlsp', 'cmd', [lsp_settings#exec_path('daggerlsp')]+lsp_settings#get('daggerlsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('daggerlsp', 'root_uri', lsp_settings#root_uri('daggerlsp'))},
      \ 'initialization_options': lsp_settings#get('daggerlsp', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('daggerlsp', 'allowlist', ['cue']),
      \ 'blocklist': lsp_settings#get('daggerlsp', 'blocklist', []),
      \ 'config': lsp_settings#get('daggerlsp', 'config', lsp_settings#server_config('daggerlsp')),
      \ 'workspace_config': lsp_settings#get('daggerlsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('daggerlsp', 'semantic_highlight', {}),
      \ }
augroup END
