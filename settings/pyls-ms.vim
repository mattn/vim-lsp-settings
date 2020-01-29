augroup vimlsp_settings_pyls_ms
  au!
  LspRegisterServer {
      \ 'name': 'pyls-ms',
      \ 'cmd': {server_info->lsp_settings#get('pyls-ms', 'cmd', [lsp_settings#exec_path('pyls-ms')])},
      \ 'root_uri':{server_info->lsp_settings#get('pyls-ms', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
	  \ 'initialization_options': lsp_settings#get('pyls-ms', 'initialization_options', {
      \   'analysisUpdates': v:true,
      \   'asyncStartup': v:true,
      \   'displayOptions': {},
      \   'interpreter': {
      \      'properties': {
	  \        'InterpreterPath': exepath('python'),
      \        'UseDefaultDatabase': v:true,
      \        'Version': matchstr(system('python -V'), '\s\zs\S\+'),
      \      },
      \    },
	  \  }),
      \ 'whitelist': lsp_settings#get('pyls-ms', 'whitelist', ['python']),
      \ 'blacklist': lsp_settings#get('pyls-ms', 'blacklist', []),
      \ 'config': lsp_settings#get('pyls-ms', 'config', {}),
      \ 'workspace_config': lsp_settings#get('pyls-ms', 'workspace_config', {
      \   'python': {
      \     'analysis': {
      \       'errors': [],
      \       'info': [],
      \       'disabled': [],
      \     },
      \   },
      \ }),
      \ }
augroup END
