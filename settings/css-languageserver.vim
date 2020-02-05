augroup vimlsp_settings_css_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'css-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('css-languageserver', 'cmd', [lsp_settings#exec_path('css-languageserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('css-languageserver', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('css-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('css-languageserver', 'whitelist', ['css', 'less', 'sass']),
      \ 'blacklist': lsp_settings#get('css-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('css-languageserver', 'config', {'typed_pattern': '-\?[a-zA-Z_]\+[_a-zA-Z0-9-]*$\|\k\+$'}),
      \ 'workspace_config': lsp_settings#get('css-languageserver', 'workspace_config', {
      \   'css': {'lint': {'validProperties': []}},
      \   'less': {'lint': {'validProperties': []}},
      \   'sass': {'lint': {'validProperties': []}},
      \ })}
augroup END
