augroup vimlsp_settings_json_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'json-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('json-languageserver', 'cmd', [lsp_settings#exec_path('json-languageserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('json-langserver', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/'])))},
      \ 'initialization_options': lsp_settings#get('json-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('json-languageserver', 'whitelist', ['json']),
      \ 'blacklist': lsp_settings#get('json-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('json-languageserver', 'config', {}),
      \ 'workspace_config': lsp_settings#get('json-languageserver', 'workspace_config', {}),
      \ }
augroup END
