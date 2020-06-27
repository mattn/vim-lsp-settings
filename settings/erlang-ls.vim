augroup vim_lsp_settings_erlang_ls
  au!
  LspRegisterServer {
      \ 'name': 'erlang-ls',
      \ 'cmd': {server_info->lsp_settings#get('erlang-ls', 'cmd', [lsp_settings#exec_path('erlang-ls'), '--transport', 'stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('erlang-ls', 'root_uri', lsp_settings#root_uri('erlang-ls'))},
      \ 'initialization_options': lsp_settings#get('erlang-ls', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('erlang-ls', 'allowlist', ['erlang']),
      \ 'blocklist': lsp_settings#get('erlang-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('erlang-ls', 'config', lsp_settings#server_config('erlang-ls')),
      \ 'workspace_config': lsp_settings#get('erlang-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('erlang-ls', 'semantic_highlight', {}),
      \ }
augroup END
