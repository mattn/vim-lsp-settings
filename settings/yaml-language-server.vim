augroup vim_lsp_settings_yaml_language_server
  au!
  LspRegisterServer {
      \ 'name': 'yaml-language-server',
      \ 'cmd': {server_info->lsp_settings#get('yaml-language-server', 'cmd', [lsp_settings#exec_path('yaml-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('yaml-language-server', 'root_uri', lsp_settings#root_uri('yaml-language-server'))},
      \ 'initialization_options': lsp_settings#get('yaml-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('yaml-language-server', 'allowlist', ['yaml']),
      \ 'blocklist': lsp_settings#get('yaml-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('yaml-language-server', 'config', lsp_settings#server_config('yaml-language-server')),
      \ 'workspace_config': lsp_settings#get('yaml-language-server', 'workspace_config', {name, key->{'json': {'format': {'enable': v:true}, 'schemas': lsp_settings#utils#load_schemas('yaml-language-server')}}}),
      \ 'semantic_highlight': lsp_settings#get('yaml-language-server', 'semantic_highlight', {}),
      \ }
augroup END
