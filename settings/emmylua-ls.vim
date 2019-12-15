augroup vimlsp_settings_emmylua_ls
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'emmylua-ls',
      \ 'cmd': lsp_settings#get('emmylua-ls', 'cmd', {server_info->[lsp_settings#exec_path('emmylua-ls')]}),
      \ 'initialization_options': lsp_settings#get('emmylua-ls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('emmylua-ls', 'whitelist', ['lua']),
      \ 'blacklist': lsp_settings#get('emmylua-ls', 'blacklist', []),
      \ 'config': lsp_settings#get('emmylua-ls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('emmylua-ls', 'workspace_config', {}),
      \ })
augroup END
