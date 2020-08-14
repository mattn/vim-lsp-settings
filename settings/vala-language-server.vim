augroup vim_lsp_settings_vala_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vala-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vala-language-server', 'cmd', [lsp_settings#exec_path('vala-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('vala-language-server', 'root_uri', lsp_settings#root_uri('vala-language-server'))},
      \ 'initialization_options': lsp_settings#get('vala-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('vala-language-server', 'allowlist', ['vala']),
      \ 'blocklist': lsp_settings#get('vala-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('vala-language-server', 'config', lsp_settings#server_config('vala-language-server')),
      \ 'workspace_config': lsp_settings#get('vala-language-server', 'workspace_config', {name, key->{'json': {'format': {'enable': v:true}, 'schemas': lsp_settings#utils#load_schemas('vala-language-server')}}}),
      \ 'semantic_highlight': lsp_settings#get('vala-language-server', 'semantic_highlight', {}),
      \ }
augroup END
