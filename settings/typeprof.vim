augroup vim_lsp_settings_typeprof
  au!
  LspRegisterServer {
      \ 'name': 'typeprof',
      \ 'cmd': {server_info->lsp_settings#get('typeprof', 'cmd', [lsp_settings#exec_path('typeprof')]+lsp_settings#get('typeprof', 'args', ['--lsp', '--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('typeprof', 'root_uri', lsp_settings#root_uri('typeprof'))},
      \ 'initialization_options': lsp_settings#get('typeprof', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('typeprof', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('typeprof', 'blocklist', []),
      \ 'config': lsp_settings#get('typeprof', 'config', lsp_settings#server_config('typeprof')),
      \ 'workspace_config': lsp_settings#get('typeprof', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('typeprof', 'semantic_highlight', {}),
      \ }
augroup END
