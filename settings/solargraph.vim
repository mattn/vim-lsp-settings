augroup vim_lsp_settings_solargraph
  au!
  LspRegisterServer {
      \ 'name': 'solargraph',
      \ 'cmd': {server_info->lsp_settings#get('solargraph', 'cmd', [lsp_settings#exec_path('solargraph'), 'stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('solargraph', 'root_uri', lsp_settings#root_uri('solargraph'))},
      \ 'initialization_options': lsp_settings#get('solargraph', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('solargraph', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('solargraph', 'blocklist', []),
      \ 'config': lsp_settings#get('solargraph', 'config', lsp_settings#server_config('solargraph')),
      \ 'workspace_config': lsp_settings#get('solargraph', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('solargraph', 'semantic_highlight', {}),
      \ }
augroup END
