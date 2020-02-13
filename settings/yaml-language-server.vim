augroup vimlsp_settings_yaml_language_server
  au!
  LspRegisterServer {
      \ 'name': 'yaml-language-server',
      \ 'cmd': {server_info->lsp_settings#get('yaml-language-server', 'cmd', [lsp_settings#exec_path('yaml-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('yaml-language-server', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('yaml-language-server', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('yaml-language-server', 'whitelist', ['yaml']),
      \ 'blacklist': lsp_settings#get('yaml-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('yaml-language-server', 'config', lsp_settings#server_config('yaml-language-server')),
      \ 'workspace_config': lsp_settings#get('yaml-language-server', 'workspace_config', {name, key->{'json': {'format': {'enable': v:true}, 'schemas': json_decode(join(readfile(expand('<sfile>:h:h') . '/data/catalog.json'), "\n"))['schemas']}}}),
      \ }
augroup END
