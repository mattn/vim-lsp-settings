augroup vimlsp_settings_clangd
  au!
  let settings = {
      \ 'name': 'clangd',
      \ 'cmd': {server_info->lsp_settings#get('clangd', 'cmd', [lsp_settings#exec_path('clangd')])},
      \ 'initialization_options': lsp_settings#get('clangd', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('clangd', 'whitelist', ['c', 'cpp', 'objc', 'objcpp']),
      \ 'blacklist': lsp_settings#get('clangd', 'blacklist', []),
      \ 'config': lsp_settings#get('clangd', 'config', {}),
      \ 'workspace_config': lsp_settings#get('clangd', 'workspace_config', {}),
      \ }
  if has('patch-8.1.000')
    autocmd User lsp_setup ++once call lsp#register_server(settings)
  else
    autocmd User lsp_setup call lsp#register_server(settings)
  endif
augroup END
