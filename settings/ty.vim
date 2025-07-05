augroup vim_lsp_settings_ty
  au!
  LspRegisterServer {
      \ 'name': 'ty',
      \ 'cmd': {server_info->lsp_settings#get('ty', 'cmd', [lsp_settings#exec_path('ty')]+lsp_settings#get('ty', 'args', ['server']))},
      \ 'root_uri':{server_info->lsp_settings#get('ty', 'root_uri', lsp_settings#root_uri('ty'))},
      \ 'initialization_options': lsp_settings#get('ty', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('ty', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('ty', 'blocklist', []),
      \ 'config': lsp_settings#get('ty', 'config', lsp_settings#server_config('ty')),
      \ 'workspace_config': lsp_settings#get('ty', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ty', 'semantic_highlight', {}),
      \ }
augroup END
