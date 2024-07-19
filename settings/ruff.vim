augroup vim_lsp_settings_ruff
  au!
  LspRegisterServer {
      \ 'name': 'ruff',
      \ 'cmd': {server_info->lsp_settings#get('ruff', 'cmd', [lsp_settings#exec_path('ruff')]+lsp_settings#get('ruff', 'args', ['server']))},
      \ 'root_uri':{server_info->lsp_settings#get('ruff', 'root_uri', lsp_settings#root_uri('ruff'))},
      \ 'initialization_options': lsp_settings#get('ruff', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('ruff', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('ruff', 'blocklist', []),
      \ 'config': lsp_settings#get('ruff', 'config', lsp_settings#server_config('ruff')),
      \ 'workspace_config': lsp_settings#get('ruff', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ruff', 'semantic_highlight', {}),
      \ }
augroup END
