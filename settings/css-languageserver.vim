augroup vim_lsp_settings_css_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'css-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('css-languageserver', 'cmd', [lsp_settings#exec_path('css-languageserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('css-languageserver', 'root_uri', lsp_settings#root_uri('css-languageserver'))},
      \ 'initialization_options': lsp_settings#get('css-languageserver', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('css-languageserver', 'allowlist', ['css', 'less', 'sass', 'scss']),
      \ 'blocklist': lsp_settings#get('css-languageserver', 'blocklist', []),
      \ 'config': lsp_settings#get('css-languageserver', 'config', lsp_settings#server_config('css-languageserver')),
      \ 'workspace_config': lsp_settings#get('css-languageserver', 'workspace_config', {
      \   'css': {'lint': {'validProperties': []}},
      \   'less': {'lint': {'validProperties': []}},
      \   'sass': {'lint': {'validProperties': []}},
      \   'scss': {'lint': {'validProperties': []}},
      \ }),
      \ 'semantic_highlight': lsp_settings#get('css-languageserver', 'semantic_highlight', {}),
      \ }
augroup END
