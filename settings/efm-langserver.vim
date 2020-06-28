augroup vim_lsp_settings_efm_langserver
  au!
  LspRegisterServer {
      \ 'name': 'efm-langserver',
      \ 'cmd': {server_info->lsp_settings#get('efm-langserver', 'cmd', [lsp_settings#exec_path('efm-langserver')])},
      \ 'root_uri':{server_info->lsp_settings#get('efm-langserver', 'root_uri', lsp_settings#root_uri('efm-langserver'))},
      \ 'initialization_options': lsp_settings#get('efm-langserver', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('efm-langserver', 'allowlist', ['*']),
      \ 'blocklist': lsp_settings#get('efm-langserver', 'blocklist', []),
      \ 'config': lsp_settings#get('efm-langserver', 'config', lsp_settings#server_config('efm-langserver')),
      \ 'workspace_config': lsp_settings#get('efm-langserver', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('efm-langserver', 'semantic_highlight', {}),
      \ }
augroup END
