augroup vim_lsp_settings_typescript_go
  au!
  LspRegisterServer {
      \ 'name': 'typescript-go',
      \ 'cmd': {server_info->lsp_settings#get('typescript-go', 'cmd', [lsp_settings#exec_path('tsgo')]+lsp_settings#get('typescript-go', 'args', ['--lsp', '--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('typescript-go', 'root_uri', lsp_settings#root_uri('typescript-go'))},
      \ 'initialization_options': lsp_settings#get('typescript-go', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('typescript-go', 'allowlist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'json']),
      \ 'blocklist': lsp_settings#get('typescript-go', 'blocklist', []),
      \ 'config': lsp_settings#get('typescript-go', 'config', {}),
      \ 'workspace_config': lsp_settings#get('typescript-go', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('typescript-go', 'semantic_highlight', {}),
      \}
augroup END
