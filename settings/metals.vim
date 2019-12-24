augroup vimlsp_settings_metals
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'metals',
      \ 'cmd': {server_info->lsp_settings#get('metals', 'cmd', [lsp_settings#exec_path('metals')])},
      \ 'root_uri':{server_info->lsp_settings#get('metals', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/', 'build.sbt'])))},
      \ 'whitelist': lsp_settings#get('metals', 'whitelist', ['scala', 'sbt']),
      \ 'blacklist': lsp_settings#get('metals', 'blacklist', []),
      \ 'config': lsp_settings#get('metals', 'config', {}),
      \ 'workspace_config': lsp_settings#get('metals', 'workspace_config', {}),
      \ })
augroup END
