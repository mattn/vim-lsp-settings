augroup vimlsp_settings_emmylua_ls
  au!
  let settings = {
      \ 'name': 'emmylua-ls',
      \ 'cmd': {server_info->lsp_settings#get('emmylua-ls', 'cmd', [lsp_settings#exec_path('emmylua-ls')])},
      \ 'initialization_options': lsp_settings#get('emmylua-ls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('emmylua-ls', 'whitelist', ['lua']),
      \ 'blacklist': lsp_settings#get('emmylua-ls', 'blacklist', []),
      \ 'config': lsp_settings#get('emmylua-ls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('emmylua-ls', 'workspace_config', {}),
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
