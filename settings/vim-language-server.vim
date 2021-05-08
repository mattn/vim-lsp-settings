augroup vim_lsp_settings_vim_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vim-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vim-language-server', 'cmd', [lsp_settings#exec_path('vim-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('vim-language-server', 'root_uri', lsp_settings#root_uri('vim-language-server'))},
      \ 'initialization_options': extend({
      \   'isNeovim': has('nvim'),
      \   'vimruntime': $VIMRUNTIME,
      \   'runtimepath': &rtp,
      \   'iskeyword': &isk . ',:',
      \   'diagnostic': {'enable': v:true}
      \  }, lsp_settings#get('vim-language-server', 'initialization_options', {}), 'force'),
      \ 'allowlist': lsp_settings#get('vim-language-server', 'allowlist', ['vim']),
      \ 'blocklist': lsp_settings#get('vimbash-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('vim-language-server', 'config', lsp_settings#server_config('vim-language-server')),
      \ 'workspace_config': lsp_settings#get('vim-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('vim-language-server', 'semantic_highlight', {}),
      \ }
augroup END
