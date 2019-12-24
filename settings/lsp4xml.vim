augroup vimlsp_settings_lsp4xml
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'lsp4xml',
      \ 'cmd': {server_info->lsp_settings#get('lsp4xml', 'cmd', [lsp_settings#exec_path('lsp4xml')])},
      \ 'root_uri':{server_info->lsp_settings#get('lsp4xml', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/'])))},
      \ 'whitelist': lsp_settings#get('lsp4xml', 'whitelist', ['xml']),
      \ 'blacklist': lsp_settings#get('lsp4xml', 'blacklist', []),
      \ 'config': lsp_settings#get('lsp4xml', 'config', {}),
      \ 'workspace_config': lsp_settings#get('lsp4xml', 'workspace_config', {}),
      \ })
augroup END
