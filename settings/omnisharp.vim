augroup vimlsp_settings_omnisharp-node-client
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'omnisharp',
      \ 'cmd': {server_info->lsp_settings#get('omnisharp-node-client', 'cmd', [lsp_settings#exec_path('omnisharp'), '-lsp'])},
      \ 'initialization_options': lsp_settings#get('omnisharp-node-client', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('omnisharp-node-client', 'whitelist', ['cs']),
      \ 'blacklist': lsp_settings#get('omnisharp-node-client', 'blacklist', []),
      \ 'config': lsp_settings#get('omnisharp-node-client', 'config', {}),
      \ 'workspace_config': lsp_settings#get('omnisharp-node-client', 'workspace_config', {}),
      \ })
augroup END
