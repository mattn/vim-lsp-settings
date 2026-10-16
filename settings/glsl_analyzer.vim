call lsp_settings#register_server({
    \ 'name': 'glsl_analyzer',
    \ 'cmd': {server_info->lsp_settings#get('glsl_analyzer', 'cmd', [lsp_settings#exec_path('glsl_analyzer')]+lsp_settings#get('glsl_analyzer', 'args', []))},
    \ 'root_uri':{server_info->lsp_settings#get('glsl_analyzer', 'root_uri', lsp_settings#root_uri('glsl_analyzer'))},
    \ 'initialization_options': lsp_settings#get('glsl_analyzer', 'initialization_options', v:null),
    \ 'allowlist': lsp_settings#get('glsl_analyzer', 'allowlist', ['glsl']),
    \ 'blocklist': lsp_settings#get('glsl_analyzer', 'blocklist', []),
    \ 'config': lsp_settings#get('glsl_analyzer', 'config', lsp_settings#server_config('glsl_analyzer')),
    \ 'workspace_config': lsp_settings#get('glsl_analyzer', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('glsl_analyzer', 'semantic_highlight', {}),
    \ })
