augroup vimlsp_settings_elixir_ls
  au!
  LspRegisterServer {
      \ 'name': 'elixir-ls',
      \ 'cmd': {server_info->lsp_settings#get('elixir-ls', 'cmd', [lsp_settings#exec_path('elixir-ls')])},
      \ 'root_uri':{server_info->lsp_settings#get('elixir-ls', 'root_uri', lsp_settings#root_uri(['.git/']))},
      \ 'initialization_options': lsp_settings#get('elixir-ls', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('elixir-ls', 'whitelist', ['elixir']),
      \ 'blacklist': lsp_settings#get('elixir-ls', 'blacklist', []),
      \ 'config': lsp_settings#get('elixir-ls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('elixir-ls', 'workspace_config', {}),
      \ }
augroup END

