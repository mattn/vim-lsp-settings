augroup vimlsp_settings_rls
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'rls',
      \ 'cmd': {server_info->lsp_settings#get('rls', 'cmd', [lsp_settings#exec_path('rls')])},
      \ 'root_uri':{server_info->lsp_settings#get('rls', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/'])))},
      \ 'initialization_options': lsp_settings#get('rls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('rls', 'whitelist', ['rust']),
      \ 'blacklist': lsp_settings#get('rls', 'blacklist', []),
      \ 'config': lsp_settings#get('rls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('rls', 'workspace_config', {}),
      \ })
augroup END
