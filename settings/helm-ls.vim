augroup vim_lsp_settings_helm_ls
  au!
  LspRegisterServer {
      \ 'name': 'helm-ls',
      \ 'cmd': {server_info->lsp_settings#get('helm-ls', 'cmd', [lsp_settings#exec_path('helm-ls')]+lsp_settings#get('helm-ls', 'args', ['serve']))},
      \ 'root_uri':{server_info->lsp_settings#get('helm-ls', 'root_uri', lsp_settings#root_uri('helm-ls'))},
      \ 'initialization_options': lsp_settings#get('helm-ls', 'initialization_options', {}),
      \ 'capabilities': lsp_settings#get('helm-ls', 'capabilities', {}),
      \ 'allowlist': lsp_settings#get('helm-ls', 'allowlist', ['helm']),
      \ 'blocklist': lsp_settings#get('helm-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('helm-ls', 'config', lsp_settings#server_config('helm-ls')),
      \ 'workspace_config': lsp_settings#get('helm-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('helm-ls', 'semantic_highlight', {}),
      \ }
augroup END
