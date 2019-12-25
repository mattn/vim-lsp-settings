augroup vimlsp_settings_vim_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vim-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vim-language-server', 'cmd', [lsp_settings#exec_path('vim-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('vim-language-server', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/', '.vim/', 'vimfiles/'])))},
      \ 'initialization_options': { 'vimruntime': $VIMRUNTIME, 'runtimepath': &rtp },
      \ 'whitelist': ['vim'],
      \ 'blacklist': lsp_settings#get('bash-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('bash-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('bash-language-server', 'workspace_config', {}),
      \ }
augroup END
