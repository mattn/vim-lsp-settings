augroup vim_lsp_settings_oxlint
  au!
  LspRegisterServer {
      \ 'name': 'oxlint',
      \ 'cmd': {server_info->lsp_settings#get('oxlint', 'cmd', [lsp_settings#exec_path('oxlint')]+lsp_settings#get('oxlint', 'args', ['--lsp']))},
      \ 'root_uri':{server_info->lsp_settings#get('oxlint', 'root_uri', lsp_settings#root_uri('oxlint'))},
      \ 'initialization_options': lsp_settings#get('oxlint', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('oxlint', 'allowlist', ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue', 'svelte', 'astro']),
      \ 'blocklist': lsp_settings#get('oxlint', 'blocklist', []),
      \ 'config': lsp_settings#get('oxlint', 'config', {}),
      \ 'workspace_config': lsp_settings#get('oxlint', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('oxlint', 'semantic_highlight', {}),
      \ }
augroup END
