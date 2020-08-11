augroup vim_lsp_settings_rome
  au!
  LspRegisterServer {
      \ 'name': 'rome-lsp',
      \ 'cmd': {server_info->lsp_settings#get('rome', 'cmd', [lsp_settings#exec_path('rome'), 'lsp'])},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.config/'))},
      \ 'initialization_options': lsp_settings#get('typescript-language-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('typescript-language-server', 'allowlist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'json']),
      \ 'blocklist': lsp_settings#get('typescript-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('typescript-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('typescript-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('typescript-language-server', 'semantic_highlight', {}),
      \}
augroup END
