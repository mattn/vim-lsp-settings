augroup vim_lsp_settings_bufls
  au!
  LspRegisterServer {
      \ 'name': 'bufls',
      \ 'cmd': {server_info->lsp_settings#get('bufls', 'cmd', [lsp_settings#exec_path('bufls')]+lsp_settings#get('bufls', 'args', ['serve']))},
      \ 'root_uri':{server_info->lsp_settings#get('bufls', 'root_uri', lsp_settings#root_uri('bufls'))},
      \ 'initialization_options': lsp_settings#get('bufls', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('bufls', 'allowlist', ['proto']),
      \ 'blocklist': lsp_settings#get('bufls', 'blocklist', []),
      \ 'config': lsp_settings#get('bufls', 'config', lsp_settings#server_config('bufls')),
      \ 'workspace_config': lsp_settings#get('bufls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('bufls', 'semantic_highlight', {}),
      \ }
augroup END
