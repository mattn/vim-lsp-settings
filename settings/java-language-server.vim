augroup vim_lsp_settings_java_language_server
  au!
  LspRegisterServer {
      \ 'name': 'java-language-server',
      \ 'cmd': {server_info->lsp_settings#get('java-language-server', 'cmd', [lsp_settings#exec_path('java-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('java-language-server', 'root_uri', lsp_settings#root_uri('java-language-server'))},
      \ 'initialization_options': lsp_settings#get('java-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('java-language-server', 'allowlist', ['java']),
      \ 'blocklist': lsp_settings#get('java-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('java-language-server', 'config', lsp_settings#server_config('java-language-server')),
      \ 'workspace_config': lsp_settings#get('java-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('java-language-server', 'semantic_highlight', {}),
      \ }
augroup END
