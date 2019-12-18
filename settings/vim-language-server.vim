augroup vimlsp_settings_vim_language_server
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'vim-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vim-language-server', 'cmd', [lsp_settings#exec_path('vim-language-server'), '--stdio'])},
      \ 'initialization_options': {
      \   'vimruntime': $VIMRUNTIME,
      \   'runtimepath': &rtp,
      \ },
      \ 'whitelist': ['vim'],
      \ })
augroup END
