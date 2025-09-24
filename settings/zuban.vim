augroup vim_lsp_settings_zuban
  au!
  LspRegisterServer {
      \ 'name': 'zuban',
      \ 'cmd': {server_info->lsp_settings#get('zuban', 'cmd', [lsp_settings#exec_path('zuban')]+lsp_settings#get('zuban', 'args', ['server']))},
      \ 'root_uri':{server_info->lsp_settings#get('zuban', 'root_uri', lsp_settings#root_uri('zuban'))},
      \ 'initialization_options': lsp_settings#get('zuban', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('zuban', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('zuban', 'blocklist', []),
      \ 'config': lsp_settings#get('zuban', 'config', lsp_settings#server_config('zuban')),
      \ 'workspace_config': lsp_settings#get('zuban', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('zuban', 'semantic_highlight', {}),
      \ }
augroup END
