augroup vim_lsp_settings_flow
  au!
  LspRegisterServer {
      \ 'name': 'flow',
      \ 'cmd': {server_info->lsp_settings#get('node', 'cmd', [lsp_settings#exec_path('flow'), 'lsp'])},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
      \ 'initialization_options': lsp_settings#get('flow', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('flow', 'allowlist', ['javascript', 'javascriptreact']),
      \ 'blocklist': lsp_settings#get('flow', 'blocklist', []),
      \ 'config': lsp_settings#get('flow', 'config', {}),
      \ 'workspace_config': lsp_settings#get('flow', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('flow', 'semantic_highlight', {}),
      \}
augroup END
