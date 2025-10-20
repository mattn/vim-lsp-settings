augroup vim_lsp_settings_buf
  au!
  LspRegisterServer {
      \ 'name': 'buf',
      \ 'cmd': {server_info->lsp_settings#get('buf', 'cmd', [lsp_settings#exec_path('buf')]+lsp_settings#get('buf', 'args', ['lsp', 'serve']))},
      \ 'root_uri':{server_info->lsp_settings#get('buf', 'root_uri', lsp_settings#root_uri('buf'))},
      \ 'initialization_options': lsp_settings#get('buf', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('buf', 'allowlist', ['proto']),
      \ 'blocklist': lsp_settings#get('buf', 'blocklist', []),
      \ 'config': lsp_settings#get('buf', 'config', lsp_settings#server_config('buf')),
      \ 'workspace_config': lsp_settings#get('buf', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('buf', 'semantic_highlight', {}),
      \ }
augroup END
