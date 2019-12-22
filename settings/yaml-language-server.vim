augroup vimlsp_settings_yaml_language_server
  au!
  let settings = {
      \ 'name': 'yaml-language-server',
      \ 'cmd': {server_info->lsp_settings#get('yaml-language-server', 'cmd', [lsp_settings#exec_path('yaml-language-server'), '--stdio'])},
      \ 'whitelist': lsp_settings#get('yaml-language-server', 'whitelist', ['yaml']),
      \ 'blacklist': lsp_settings#get('yaml-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('yaml-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('yaml-language-server', 'workspace_config', {}),
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
