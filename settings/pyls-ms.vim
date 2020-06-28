augroup vim_lsp_settings_pyls_ms
  au!
  LspRegisterServer {
      \ 'name': 'pyls-ms',
      \ 'cmd': {server_info->lsp_settings#get('pyls-ms', 'cmd', [lsp_settings#exec_path('pyls-ms')])},
      \ 'root_uri':{server_info->lsp_settings#get('pyls-ms', 'root_uri', lsp_settings#root_uri('pyls-ms'))},
      \ 'initialization_options': lsp_settings#get('pyls-ms', 'initialization_options', {
      \   'analysisUpdates': v:true,
      \   'asyncStartup': v:true,
      \   'displayOptions': {},
      \   'interpreter': {
      \      'properties': {
      \        'InterpreterPath': lsp_settings#get('pyls-ms', 'python-path', {key, name->exepath('python')}),
      \        'UseDefaultDatabase': v:true,
      \        'Version': lsp_settings#get('pyls-ms', 'python-ver', {key, name->trim(matchstr(system(
      \          shellescape(lsp_settings#get('pyls-ms', 'python-path', {key, name->exepath('python')})) . ' -V'
      \        ), '\s\zs\S\+'))}),
      \      },
      \    },
      \  }),
      \ 'allowlist': lsp_settings#get('pyls-ms', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pyls-ms', 'blocklist', []),
      \ 'config': lsp_settings#get('pyls-ms', 'config', lsp_settings#server_config('pyls-ms')),
      \ 'workspace_config': lsp_settings#get('pyls-ms', 'workspace_config', {
      \   'python': {
      \     'analysis': {
      \       'errors': [],
      \       'info': [],
      \       'disabled': [],
      \     },
      \   },
      \ }),
      \ 'semantic_highlight': lsp_settings#get('pyls-ms', 'semantic_highlight', {}),
      \ }
augroup END
