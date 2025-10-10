augroup vim_lsp_settings_package_version_server
  au!
  LspRegisterServer {
      \ 'name': 'package-version-server',
      \ 'cmd': {server_info->lsp_settings#get('package-version-server', 'cmd', [lsp_settings#exec_path('package-version-server')]+lsp_settings#get('package-version-server', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('package-version-server', 'root_uri', lsp_settings#root_uri('package-version-server'))},
      \ 'initialization_options': lsp_settings#get('package-version-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('package-version-server', 'allowlist', ['json']),
      \ 'blocklist': lsp_settings#get('package-version-server', 'blocklist', []),
      \ 'config': lsp_settings#get('package-version-server', 'config', lsp_settings#server_config('package-version-server')),
      \ 'workspace_config': lsp_settings#get('package-version-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('package-version-server', 'semantic_highlight', {}),
      \ }
augroup END
