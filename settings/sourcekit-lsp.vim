augroup vimlsp_settings_sourcekit_lsp
  au!
  LspRegisterServer {
      \ 'name': 'sourcekit-lsp',
      \ 'cmd': {server_info->lsp_settings#get('sourcekit-lsp', 'cmd', [lsp_settings#exec_path('sourcekit-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('sourcekit-lsp', 'root_uri', lsp_settings#root_uri('sourcekit-lsp'))},
      \ 'initialization_options': lsp_settings#get('sourcekit-lsp', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('sourcekit-lsp', 'whitelist', ['swift']),
      \ 'blacklist': lsp_settings#get('sourcekit-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('sourcekit-lsp', 'config', lsp_settings#server_config('sourcekit-lsp')),
      \ 'workspace_config': lsp_settings#get('sourcekit-lsp', 'workspace_config', {}),
      \ }
augroup END
