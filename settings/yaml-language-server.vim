augroup vimlsp_settings_yaml_language_server
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'yaml-language-server',
      \ 'cmd': {server_info->lsp_settings#get('yaml-language-server', 'cmd', [lsp_settings#exec_path('yaml-language-server'), '--stdio'])},
      \ 'whitelist': lsp_settings#get('yaml-language-server', 'whitelist', ['yaml']),
      \ 'blacklist': lsp_settings#get('yaml-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('yaml-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('yaml-language-server', 'workspace_config', {}),
      \ })
augroup END
