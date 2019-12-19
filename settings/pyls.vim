augroup vimlsp_settings_pyls
  au!
  let settings = {
      \ 'name': 'pyls',
      \ 'cmd': {server_info->lsp_settings#get('pyls', 'cmd', [lsp_settings#exec_path('pyls')])},
      \ 'initialization_options': lsp_settings#get('pyls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('pyls', 'whitelist', ['python']),
      \ 'blacklist': lsp_settings#get('pyls', 'blacklist', []),
      \ 'config': lsp_settings#get('pyls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('pyls', 'workspace_config', {}),
      \ }
  if has('patch-8.1.000')
    autocmd User lsp_setup ++once call lsp#register_server(settings)
  else
    autocmd User lsp_setup call lsp#register_server(settings)
  endif
augroup END
