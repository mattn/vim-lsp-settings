augroup vimlsp_settings_omnisharp_lsp
  au!
  let settings = {
      \ 'name': 'omnisharp-lsp',
      \ 'cmd': {server_info->lsp_settings#get('omnisharp-lsp', 'cmd', [lsp_settings#exec_path('omnisharp-lsp'), '-lsp'])},
      \ 'initialization_options': lsp_settings#get('omnisharp-lsp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('omnisharp-lsp', 'whitelist', ['cs']),
      \ 'blacklist': lsp_settings#get('omnisharp-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('omnisharp-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('omnisharp-lsp', 'workspace_config', {}),
      \ }
  if has('patch-8.1.000')
    autocmd User lsp_setup ++once call lsp#register_server(settings)
  else
    autocmd User lsp_setup call lsp#register_server(settings)
  endif
augroup END
