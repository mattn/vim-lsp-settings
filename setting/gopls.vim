augroup vimlsp_settings_gopls
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'gopls',
      \ 'cmd': {server_info->['gopls']},
      \ 'initialization_options': {"diagnostics": "false"},
      \ 'whitelist': ['go'],
      \ })
augroup END
