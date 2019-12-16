augroup vimlsp_settings_eclipse_jdt_ls
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'eclipse-jdt-ls',
      \ 'cmd': {server_info->lsp_settings#get('eclipse-jdt-ls', 'cmd', [lsp_settings#exec_path('eclipse-jdt-ls')])},
      \ 'initialization_options': lsp_settings#get('eclipse-jdt-ls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('eclipse-jdt-ls', 'whitelist', ['java']),
      \ 'blacklist': lsp_settings#get('eclipse-jdt-ls', 'blacklist', []),
      \ 'config': lsp_settings#get('eclipse-jdt-ls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('eclipse-jdt-ls', 'workspace_config', {}),
      \ })
augroup END
