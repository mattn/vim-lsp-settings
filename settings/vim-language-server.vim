augroup vimlsp_settings_vim_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vim-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vim-language-server', 'cmd', [lsp_settings#exec_path('vim-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('vim-language-server', 'root_uri', lsp_settings#root_uri(extend(['.vim/', 'vimfiles/'], g:lsp_settings_root_markers)))},
      \ 'initialization_options': { 'vimruntime': $VIMRUNTIME, 'runtimepath': &rtp },
      \ 'whitelist': lsp_settings#get('vim-language-server', 'whitelist', ['vim']), 
      \ 'blacklist': lsp_settings#get('vimbash-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('vim-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('vim-language-server', 'workspace_config', {}),
      \ }
augroup END
