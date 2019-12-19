augroup vimlsp_settings_gopls
  au!
  let settings = {
      \ 'name': 'gopls',
      \ 'cmd': {server_info->lsp_settings#get('gopls', 'cmd', [lsp_settings#exec_path('gopls')])},
      \ 'initialization_options': lsp_settings#get('gopls', 'initialization_options', {"diagnostics": "true"}),
      \ 'whitelist': lsp_settings#get('gopls', 'whitelist', ['go']),
      \ 'blacklist': lsp_settings#get('gopls', 'blacklist', []),
      \ 'config': lsp_settings#get('gopls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('gopls', 'workspace_config', {}),
      \ }
  if has('patch-8.1.000')
    autocmd User lsp_setup ++once call lsp#register_server(settings)
  else
    autocmd User lsp_setup call lsp#register_server(settings)
  endif
augroup END
