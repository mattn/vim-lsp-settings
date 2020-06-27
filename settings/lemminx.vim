augroup vim_lsp_settings_lemminx
  au!
  LspRegisterServer {
      \ 'name': 'lemminx',
      \ 'cmd': {server_info->lsp_settings#get('lemminx', 'cmd', [lsp_settings#exec_path('lemminx')])},
      \ 'root_uri':{server_info->lsp_settings#get('lemminx', 'root_uri', lsp_settings#root_uri('lemminx'))},
      \ 'initialization_options': lsp_settings#get('lemminx', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('lemminx', 'allowlist', ['xml']),
      \ 'blocklist': lsp_settings#get('lemminx', 'blocklist', []),
      \ 'config': lsp_settings#get('lemminx', 'config', lsp_settings#server_config('lemminx')),
      \ 'workspace_config': lsp_settings#get('lemminx', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('lemminx', 'semantic_highlight', {}),
      \ }
augroup END
