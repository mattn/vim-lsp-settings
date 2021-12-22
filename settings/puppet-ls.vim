augroup vim_lsp_settings_puppet-ls
  au!
  LspRegisterServer {
      \ 'name': 'puppet-ls',
      \ 'cmd': {server_info->lsp_settings#get('puppet-ls', 'cmd', [lsp_settings#exec_path('puppet-ls')]+lsp_settings#get('puppet-ls', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('puppet-ls', 'root_uri', lsp_settings#root_uri('puppet-ls'))},
      \ 'initialization_options': lsp_settings#get('puppet-ls', 'initialization_options', {'diagnostics': 'false'}),
      \ 'allowlist': lsp_settings#get('puppet-ls', 'allowlist', ['puppet']),
      \ 'blocklist': lsp_settings#get('puppet-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('puppet-ls', 'config', lsp_settings#server_config('puppet-ls')),
      \ 'workspace_config': lsp_settings#get('puppet-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('puppet-ls', 'semantic_highlight', {}),
      \ }
augroup END
