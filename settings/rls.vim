augroup vimlsp_settings_rls
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'rls',
      \ 'cmd': lsp_settings#get('rls', 'cmd', {server_info->[lsp_settings#exec_path('rls')]}),
      \ 'initialization_options': lsp_settings#get('rls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('rls', 'whitelist', ['rust']),
      \ 'blacklist': lsp_settings#get('rls', 'blacklist', []),
      \ 'config': lsp_settings#get('rls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('rls', 'workspace_config', {}),
      \ })
augroup END
