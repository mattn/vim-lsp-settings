augroup vimlsp_settings_intelephense_server
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'intelephense',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense-server --stdio']},
      \ 'whitelist': ['php'],
      \ })
augroup END
