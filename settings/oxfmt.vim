augroup vim_lsp_settings_oxfmt
  au!
  LspRegisterServer {
      \ 'name': 'oxfmt',
      \ 'cmd': {server_info->lsp_settings#get('oxfmt', 'cmd', [lsp_settings#exec_path('oxfmt')]+lsp_settings#get('oxfmt', 'args', ['--lsp']))},
      \ 'root_uri':{server_info->lsp_settings#get('oxfmt', 'root_uri', lsp_settings#root_uri('oxfmt'))},
      \ 'initialization_options': lsp_settings#get('oxfmt', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('oxfmt', 'allowlist', ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue', 'svelte', 'astro']),
      \ 'blocklist': lsp_settings#get('oxfmt', 'blocklist', []),
      \ 'config': lsp_settings#get('oxfmt', 'config', {}),
      \ 'workspace_config': lsp_settings#get('oxfmt', 'workspace_config', {
      \   'oxc_language_server': {
      \     'fmt.experimental': v:true,
      \   },
      \ }),
      \ 'semantic_highlight': lsp_settings#get('oxfmt', 'semantic_highlight', {}),
      \ }
augroup END
