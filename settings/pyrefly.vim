augroup vim_lsp_settings_pyrefly
  au!
  LspRegisterServer {
      \ 'name': 'pyrefly',
      \ 'cmd': {server_info->lsp_settings#get('pyrefly', 'cmd', [lsp_settings#exec_path('pyrefly')]+lsp_settings#get('pyrefly', 'args', ['lsp']))},
      \ 'root_uri':{server_info->lsp_settings#get('pyrefly', 'root_uri', lsp_settings#root_uri('pyrefly'))},
      \ 'initialization_options': lsp_settings#get('pyrefly', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('pyrefly', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pyrefly', 'blocklist', []),
      \ 'config': lsp_settings#get('pyrefly', 'config', lsp_settings#server_config('pyrefly')),
      \ 'workspace_config': lsp_settings#get('pyrefly', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('pyrefly', 'semantic_highlight', {}),
      \ }
augroup END
