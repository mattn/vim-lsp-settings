augroup vimlsp_settings_erlang_ls
  au!
  LspRegisterServer {
      \ 'name': 'erlang-ls',
      \ 'cmd': {server_info->lsp_settings#get('erlang-ls', 'cmd', [lsp_settings#exec_path('erlang-ls'), '--transport', 'stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('erlang-ls', 'root_uri', lsp_settings#root_uri(['.git/', 'rebar.config']))},
      \ 'initialization_options': lsp_settings#get('erlang-ls', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('erlang-ls', 'whitelist', ['erlang']),
      \ 'blacklist': lsp_settings#get('erlang-ls', 'blacklist', []),
      \ 'config': lsp_settings#get('erlang-ls', 'config', {}),
      \ 'workspace_config': lsp_settings#get('erlang-ls', 'workspace_config', {}),
      \ }
augroup END
