augroup vimlsp_settings_json_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'json-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('json-languageserver', 'cmd', [lsp_settings#exec_path('json-languageserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('json-languageserver', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('json-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('json-languageserver', 'whitelist', ['json', 'jsonc']),
      \ 'blacklist': lsp_settings#get('json-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('json-languageserver', 'config', {}),
      \ 'workspace_config': lsp_settings#get('json-languageserver', 'workspace_config', {name, key->{'json': {'format': {'enable': v:true}, 'schemas': json_decode(join(readfile(expand('<sfile>:h:h') . '/data/catalog.json'), "\n"))['schemas']}}}),
      \ }
augroup END
