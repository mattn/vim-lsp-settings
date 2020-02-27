augroup vimlsp_settings_bash_language_server
  au!
  LspRegisterServer {
      \ 'name': 'bash-language-server',
      \ 'cmd': {server_info->lsp_settings#get('bash-language-server', 'cmd', [lsp_settings#exec_path('bash-language-server'), 'start'])},
      \ 'root_uri':{server_info->lsp_settings#get('bash-language-server', 'root_uri', lsp_settings#root_uri('bash-language-server'))},
      \ 'initialization_options': lsp_settings#get('bash-language-server', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('bash-language-server', 'whitelist', ['sh']),
      \ 'blacklist': lsp_settings#get('bash-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('bash-language-server', 'config', lsp_settings#server_config('bash-language-server')),
      \ 'workspace_config': lsp_settings#get('bash-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('bash-language-server', 'semantic_highlight', {}),
      \ }
augroup END
