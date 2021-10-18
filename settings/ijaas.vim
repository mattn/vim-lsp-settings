augroup vim_lsp_settings_ijaas
  au!
  LspRegisterServer {
      \ 'name': 'ijaas',
      \ 'tcp': {server_info->lsp_settings#get('ijaas', 'tcp', '127.0.0.1:5800')},
      \ 'root_uri':{server_info->lsp_settings#get('ijaas', 'root_uri', lsp_settings#root_uri('ijaas'))},
      \ 'initialization_options': lsp_settings#get('ijaas', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('ijaas', 'allowlist', ['java']),
      \ 'blocklist': lsp_settings#get('ijaas', 'blocklist', []),
      \ 'config': lsp_settings#get('ijaas', 'config', lsp_settings#server_config('ijaas')),
      \ 'workspace_config': lsp_settings#get('ijaas', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ijaas', 'semantic_highlight', {}),
      \ }
augroup END
