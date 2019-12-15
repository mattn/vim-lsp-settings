augroup vimlsp_settings_clangd
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'clangd',
      \ 'cmd': lsp_settings#get('clangd', 'cmd', {server_info->[lsp_settings#exec_path('clangd')]}),
      \ 'initialization_options': lsp_settings#get('clangd', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('clangd', 'whitelist', ['c', 'cpp', 'objc', 'objcpp']),
      \ 'blacklist': lsp_settings#get('clangd', 'blacklist', []),
      \ 'config': lsp_settings#get('clangd', 'config', {}),
      \ 'workspace_config': lsp_settings#get('clangd', 'workspace_config', {}),
      \ })
augroup END
