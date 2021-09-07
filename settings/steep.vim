augroup vim_lsp_settings_steep
  au!
  LspRegisterServer {
      \ 'name': 'steep',
      \ 'cmd': {server_info->lsp_settings#get('steep', 'cmd', [lsp_settings#exec_path('steep'), 'langserver', printf('--steepfile=%s', lsp#utils#find_nearest_parent_file(lsp#utils#get_buffer_path(), 'Steepfile'))]+lsp_settings#get('steep', 'args', []))},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Steepfile'))},
      \ 'initialization_options': lsp_settings#get('steep', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('steep', 'allowlist', {x->empty(lsp_settings#root_path(['Steepfile'])) ? [] : ['ruby']}),
      \ 'blocklist': lsp_settings#get('steep', 'blocklist', []),
      \ 'config': lsp_settings#get('steep', 'config', lsp_settings#server_config('steep')),
      \ 'workspace_config': lsp_settings#get('steep', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('steep', 'semantic_highlight', {}),
      \ }
augroup END
