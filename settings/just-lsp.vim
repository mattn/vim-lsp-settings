call lsp_settings#register_server({
    \ 'name': 'just-lsp',
    \ 'cmd': {server_info->lsp_settings#get('just-lsp', 'cmd', [lsp_settings#exec_path('just-lsp')]+lsp_settings#get('just-lsp', 'args', []))},
    \ 'root_uri':{server_info->lsp_settings#get('just-lsp', 'root_uri', lsp_settings#root_uri('just-lsp'))},
    \ 'initialization_options': lsp_settings#get('just-lsp', 'initialization_options', {}),
    \ 'allowlist': lsp_settings#get('just-lsp', 'allowlist', ['just']),
    \ 'blocklist': lsp_settings#get('just-lsp', 'blocklist', []),
    \ 'config': lsp_settings#get('just-lsp', 'config', lsp_settings#server_config('just-lsp')),
    \ 'workspace_config': lsp_settings#get('just-lsp', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('just-lsp', 'semantic_highlight', {}),
    \ })
