augroup vim_lsp_settings_tinymist
  au!
  LspRegisterServer {
      \ 'name': 'tinymist',
      \ 'cmd': {server_info->lsp_settings#get('tinymist', 'cmd', [lsp_settings#exec_path('tinymist')]+lsp_settings#get('tinymist', 'args', ['lsp']))},
      \ 'root_uri':{server_info->lsp_settings#get('tinymist', 'root_uri', lsp_settings#root_uri('tinymist'))},
      \ 'initialization_options': lsp_settings#get('tinymist', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('tinymist', 'allowlist', ['typst', 'typ']),
      \ 'blocklist': lsp_settings#get('tinymist', 'blocklist', []),
      \ 'config': lsp_settings#get('tinymist', 'config', lsp_settings#server_config('tinymist')),
      \ 'workspace_config': lsp_settings#get('tinymist', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('tinymist', 'semantic_highlight', {}),
      \ }
augroup END
