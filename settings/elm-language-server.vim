augroup vimlsp_settings_elm_language_server
  au!
  LspRegisterServer {
      \ 'name': 'elm-language-server',
      \ 'cmd': {server_info->lsp_settings#get('elm-language-server', 'cmd', [lsp_settings#exec_path('elm-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('elm-language-server', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/', 'elm.json'])))},
      \ 'initialization_options': lsp_settings#get('elm-language-server', 'initialization_options', {'elmPath': 'elm', 'runtime': 'node', 'elmFormatPath': 'elm-format', 'elmTestPath': 'elm-test'}),
      \ 'whitelist': lsp_settings#get('elm-language-server', 'whitelist', ['elm', 'elm.tsx']),
      \ 'blacklist': lsp_settings#get('elm-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('elm-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('elm-language-server', 'workspace_config', {}),
      \ }
augroup END
