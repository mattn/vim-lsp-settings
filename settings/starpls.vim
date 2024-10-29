augroup vim_lsp_settings_starpls
  au!
  LspRegisterServer {
      \ 'name': 'starpls',
      \ 'cmd': {server_info->lsp_settings#get('starpls', 'cmd', [lsp_settings#exec_path('starpls')]+lsp_settings#get('starpls', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('starpls', 'root_uri', lsp_settings#root_uri('starpls'))},
      \ 'initialization_options': lsp_settings#get('starpls', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('starpls', 'allowlist', ['bzl', 'starlark']),
      \ 'blocklist': lsp_settings#get('starpls', 'blocklist', []),
      \ 'config': lsp_settings#get('starpls', 'config', lsp_settings#server_config('starpls')),
      \ 'workspace_config': lsp_settings#get('starpls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('starpls', 'semantic_highlight', {}),
      \ }
augroup END

