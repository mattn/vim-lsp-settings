augroup vimlsp_settings_clangd
  au!
  LspRegisterServer {
      \ 'name': 'clangd',
      \ 'cmd': {server_info->lsp_settings#get('clangd', 'cmd', [lsp_settings#exec_path('clangd')])},
      \ 'root_uri':{server_info->lsp_settings#get('clangd', 'root_uri', lsp_settings#root_uri(['.git/']))},
      \ 'initialization_options': lsp_settings#get('clangd', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('clangd', 'whitelist', ['c', 'cpp', 'objc', 'objcpp']),
      \ 'blacklist': lsp_settings#get('clangd', 'blacklist', []),
      \ 'config': lsp_settings#get('clangd', 'config', {}),
      \ 'workspace_config': lsp_settings#get('clangd', 'workspace_config', {}),
      \ }
augroup END
