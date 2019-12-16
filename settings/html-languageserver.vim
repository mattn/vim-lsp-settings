augroup vimlsp_settings_html_languageserver
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'html-languageserver',
      \ 'cmd': lsp_settings#get('html-languageserver', 'cmd', {server_info->[lsp_settings#exec_path('html-languageserver'), '--stdio']}),
      \ 'initialization_options': lsp_settings#get('html-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('html-languageserver', 'whitelist', ['html']),
      \ 'blacklist': lsp_settings#get('html-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('html-languageserver', 'config', {}),
      \ 'workspace_config': lsp_settings#get('html-languageserver', 'workspace_config', {}),
      \ })
augroup END
