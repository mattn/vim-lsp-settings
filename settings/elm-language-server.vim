augroup vim_lsp_settings_elm_language_server
  au!
  LspRegisterServer {
      \ 'name': 'elm-language-server',
      \ 'cmd': {server_info->lsp_settings#get('elm-language-server', 'cmd', [lsp_settings#exec_path('elm-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('elm-language-server', 'root_uri', lsp_settings#root_uri('elm-language-server'))},
      \ 'initialization_options': lsp_settings#get('elm-language-server', 'initialization_options', {'elmPath': 'elm', 'runtime': 'node', 'elmFormatPath': 'elm-format', 'elmTestPath': 'elm-test'}),
      \ 'allowlist': lsp_settings#get('elm-language-server', 'allowlist', ['elm', 'elm.tsx']),
      \ 'blocklist': lsp_settings#get('elm-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('elm-language-server', 'config', lsp_settings#server_config('elm-language-server')),
      \ 'workspace_config': lsp_settings#get('elm-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('elm-language-server', 'semantic_highlight', {}),
      \ }
augroup END
