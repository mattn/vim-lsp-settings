augroup vimlsp_settings_vls
  au!
  LspRegisterServer {
      \ 'name': 'vls',
      \ 'cmd': {server_info->lsp_settings#get('vls', 'cmd', [lsp_settings#exec_path('vls')])},
      \ 'root_uri':{server_info->lsp_settings#get('vls', 'root_uri', lsp_settings#root_uri(['.git/', 'package.json']))},
      \ 'initialization_options': lsp_settings#get('vls', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('vls', 'whitelist', ['vue']),
      \ 'blacklist': lsp_settings#get('vls', 'blacklist', []),
      \ 'config': lsp_settings#get('vls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('vls', 'workspace_config', {}),
      \ }
augroup END
