augroup vimlsp_settings_dockerfile_language_server_nodejs
  au!
  LspRegisterServer {
      \ 'name': 'docker-langserver',
      \ 'cmd': {server_info->lsp_settings#get('docker-langserver', 'cmd', [lsp_settings#exec_path('docker-langserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/']))},
      \ 'whitelist': lsp_settings#get('docker-langserver', 'whitelist', ['dockerfile']),
      \ 'blacklist': lsp_settings#get('docker-langserver', 'blacklist', []),
      \ 'config': lsp_settings#get('docker-langserver', 'config', {}),
      \ 'workspace_config': lsp_settings#get('docker-langserver', 'workspace_config', {}),
      \ }
augroup END
