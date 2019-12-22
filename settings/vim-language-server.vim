augroup vimlsp_settings_vim_language_server
  au!
  let settings = {
      \ 'name': 'vim-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vim-language-server', 'cmd', [lsp_settings#exec_path('vim-language-server'), '--stdio'])},
      \ 'initialization_options': {
      \   'vimruntime': $VIMRUNTIME,
      \   'runtimepath': &rtp,
      \ },
      \ 'whitelist': ['vim'],
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
