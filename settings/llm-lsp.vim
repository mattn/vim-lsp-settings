call lsp_settings#register_server({
    \ 'name': 'llm-lsp',
    \ 'cmd': {server_info->lsp_settings#get('llm-lsp', 'cmd', [lsp_settings#exec_path('llm-lsp')]+lsp_settings#get('llm-lsp', 'args', []))},
    \ 'root_uri':{server_info->lsp_settings#get('llm-lsp', 'root_uri', lsp_settings#root_uri('llm-lsp'))},
    \ 'initialization_options': lsp_settings#get('llm-lsp', 'initialization_options', v:null),
    \ 'allowlist': lsp_settings#get('llm-lsp', 'allowlist', ['*']),
    \ 'blocklist': lsp_settings#get('llm-lsp', 'blocklist', []),
    \ 'config': lsp_settings#get('llm-lsp', 'config', lsp_settings#server_config('llm-lsp')),
    \ 'workspace_config': lsp_settings#get('llm-lsp', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('llm-lsp', 'semantic_highlight', {}),
    \ })
