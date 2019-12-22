augroup vimlsp_settings_bash_language_server
  au!
  let settings = {
      \ 'name': 'bash-language-server',
      \ 'cmd': {server_info->lsp_settings#get('bash-language-server', 'cmd', [lsp_settings#exec_path('bash-language-server'), 'start'])},
      \ 'whitelist': lsp_settings#get('bash-language-server', 'whitelist', ['sh']),
      \ 'blacklist': lsp_settings#get('bash-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('bash-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('bash-language-server', 'workspace_config', {}),
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
