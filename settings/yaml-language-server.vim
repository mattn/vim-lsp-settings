augroup vimlsp_settings_yaml_language_server
  au!
  LspRegisterServer {
      \ 'name': 'yaml-language-server',
      \ 'cmd': {server_info->lsp_settings#get('yaml-language-server', 'cmd', [lsp_settings#exec_path('yaml-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('yaml-language-server', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/'])))},
      \ 'whitelist': lsp_settings#get('yaml-language-server', 'whitelist', ['yaml']),
      \ 'blacklist': lsp_settings#get('yaml-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('yaml-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('yaml-language-server', 'workspace_config', {}),
      \ }
augroup END
