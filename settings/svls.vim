augroup vimlsp_settings_svls
  au!
  LspRegisterServer {
      \ 'name': 'svls',
      \ 'cmd': {server_info->lsp_settings#get('svls', 'cmd', [lsp_settings#exec_path('svls'), '-d'])},
      \ 'root_uri':{server_info->lsp_settings#get('svls', 'root_uri', lsp_settings#root_uri(extend(['package.json'], g:lsp_settings_root_markers)))},
      \ 'initialization_options': lsp_settings#get('svls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('svls', 'whitelist', ['systemverilog']),
      \ 'blacklist': lsp_settings#get('svls', 'blacklist', []),
      \ 'config': lsp_settings#get('svls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('svls', 'workspace_config', {}),
      \ }
augroup END
