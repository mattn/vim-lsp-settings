augroup vim_lsp_settings_tsc
  au!
  LspRegisterServer {
    \ 'name': 'tsc',
    \ 'cmd': {server_info->lsp_settings#get('tsc', 'cmd', [lsp_settings#exec_path('tsc')]+lsp_settings#get('tsc', 'args', ['--lsp', '--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('tsc', 'root_uri', lsp_settings#root_uri('tsc'))},
    \ 'initialization_options': lsp_settings#get('tsc', 'initialization_options', {}),
    \ 'allowlist': lsp_settings#get('tsc', 'allowlist', ['typescript', 'typescriptreact', 'typescript.tsx']),
    \ 'blocklist': lsp_settings#get('tsc', 'blocklist', []),
    \ 'config': lsp_settings#get('tsc', 'config', {}),
    \ 'workspace_config': lsp_settings#get('tsc', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('tsc', 'semantic_highlight', {}),
    \ }
augroup END
