augroup vim_lsp_settings_intelephense_server
  au!
  LspRegisterServer {
      \ 'name': 'intelephense',
      \ 'cmd': {server_info->lsp_settings#get('intelephense', 'cmd', [lsp_settings#exec_path('intelephense'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('intelephense', 'root_uri', lsp_settings#root_uri('intelephense'))},
      \ 'initialization_options': lsp_settings#get('intelephense', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('intelephense', 'allowlist', ['php']),
      \ 'blocklist': lsp_settings#get('intelephense', 'blocklist', []),
      \ 'config': lsp_settings#get('intelephense', 'config', lsp_settings#server_config('intelephense')),
      \ 'workspace_config': lsp_settings#get('intelephense', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('intelephense', 'semantic_highlight', {}),
      \ }
augroup END
