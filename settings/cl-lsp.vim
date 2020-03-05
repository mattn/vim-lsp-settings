augroup vimlsp_settings_cl_lsp
  au!
  LspRegisterServer {
      \ 'name': 'cl-lsp',
      \ 'cmd': {server_info->lsp_settings#get('cl-lsp', 'cmd', {key, name-> ['ros', '-Q', '--', trim(filter(systemlist('ros version'), 'v:val=~"^homedir"')[0][8:], '"''') . '/bin/cl-lsp', 'stdio']})},
      \ 'root_uri':{server_info->lsp_settings#get('cl-lsp', 'root_uri', lsp_settings#root_uri('cl-lsp'))},
      \ 'initialization_options': lsp_settings#get('cl-lsp', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('cl-lsp', 'whitelist', ['lisp']),
      \ 'blacklist': lsp_settings#get('cl-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('cl-lsp', 'config', lsp_settings#server_config('cl-lsp')),
      \ 'workspace_config': lsp_settings#get('cl-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('cl-lsp', 'semantic_highlight', {}),
      \ }
augroup END
