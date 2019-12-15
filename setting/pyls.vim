augroup vimlsp_settings_pyls
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': lsp_settings#get('pyls', 'cmd', {server_info->['pyls']}),
      \ 'initialization_options': lsp_settings#get('pyls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('pyls', 'whitelist', ['python']),
      \ 'blacklist': lsp_settings#get('pyls', 'blacklist', []),
      \ 'config': lsp_settings#get('pyls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('pyls', 'workspace_config', {}),
      \ })
augroup END
