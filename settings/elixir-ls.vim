augroup vim_lsp_settings_elixir_ls
  au!
  LspRegisterServer {
      \ 'name': 'elixir-ls',
      \ 'cmd': {server_info->lsp_settings#get('elixir-ls', 'cmd', [lsp_settings#exec_path('elixir-ls')])},
      \ 'root_uri':{server_info->lsp_settings#get('elixir-ls', 'root_uri', lsp_settings#root_uri('elixir-ls'))},
      \ 'initialization_options': lsp_settings#get('elixir-ls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('elixir-ls', 'allowlist', ['elixir']),
      \ 'blocklist': lsp_settings#get('elixir-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('elixir-ls', 'config', lsp_settings#server_config('elixir-ls')),
      \ 'workspace_config': lsp_settings#get('elixir-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('elixir-ls', 'semantic_highlight', {}),
      \ }
augroup END

