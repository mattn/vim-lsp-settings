augroup vim_lsp_settings_emmylua_ls
  au!
  LspRegisterServer {
      \ 'name': 'emmylua-ls',
      \ 'cmd': {server_info->lsp_settings#get('emmylua-ls', 'cmd', [lsp_settings#exec_path('emmylua-ls')])},
      \ 'root_uri':{server_info->lsp_settings#get('emmylua-ls', 'root_uri', lsp_settings#root_uri('emmylua-ls'))},
      \ 'initialization_options': lsp_settings#get('emmylua-ls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('emmylua-ls', 'allowlist', ['lua']),
      \ 'blocklist': lsp_settings#get('emmylua-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('emmylua-ls', 'config', lsp_settings#server_config('emmylua-ls')),
      \ 'workspace_config': lsp_settings#get('emmylua-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('emmylua-ls', 'semantic_highlight', {}),
      \ }
augroup END
