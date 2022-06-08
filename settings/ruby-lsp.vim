augroup vim_lsp_settings_ruby_lsp
  au!
  LspRegisterServer {
      \ 'name': 'ruby-lsp',
      \ 'cmd': {server_info->lsp_settings#get('ruby-lsp', 'cmd', [lsp_settings#exec_path('ruby-lsp')]+lsp_settings#get('ruby-lsp', 'args', ['stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('ruby-lsp', 'root_uri', lsp_settings#root_uri('ruby-lsp'))},
      \ 'initialization_options': lsp_settings#get('ruby-lsp', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('ruby-lsp', 'allowlist', ['ruby']),
      \ 'blocklist': lsp_settings#get('ruby-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('ruby-lsp', 'config', lsp_settings#server_config('ruby-lsp')),
      \ 'workspace_config': lsp_settings#get('ruby-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('ruby-lsp', 'semantic_highlight', {}),
      \ }
augroup END
