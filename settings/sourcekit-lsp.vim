augroup vimlsp_settings_sourcekit_lsp
  au!
  LspRegisterServer {
      \ 'name': 'sourcekit-lsp',
      \ 'cmd': {server_info->lsp_settings#get('sourcekit-lsp', 'cmd', [lsp_settings#exec_path('sourcekit-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('sourcekit-lsp', 'root_uri', lsp_settings#root_uri(extend(['Package.swift', '.xcodeproj', '.xcworkspace', 'Cartfile', 'Podfile'], g:lsp_settings_root_markers)))},
      \ 'initialization_options': lsp_settings#get('sourcekit-lsp', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('sourcekit-lsp', 'whitelist', ['swift']),
      \ 'blacklist': lsp_settings#get('sourcekit-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('sourcekit-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('sourcekit-lsp', 'workspace_config', {}),
      \ }
augroup END
