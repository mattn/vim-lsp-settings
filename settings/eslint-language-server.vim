augroup vim_lsp_settings_eslint_language_server
  au!
  LspRegisterServer {
      \ 'name': 'eslint-language-server',
      \ 'cmd': {server_info->lsp_settings#get('eslint-language-server', 'cmd', [lsp_settings#exec_path('eslint-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('eslint-language-server', 'root_uri', lsp_settings#root_uri('eslint-language-server'))},
      \ 'initialization_options': lsp_settings#get('eslint-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('eslint-language-server', 'allowlist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact']),
      \ 'blocklist': lsp_settings#get('eslint-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('eslint-language-server', 'config', lsp_settings#server_config('eslint-language-server')),
      \ 'workspace_config': lsp_settings#get('eslint-language-server', 'workspace_config', {
      \   'validate': 'probe',
      \   'packageManager': 'npm',
      \   'codeActionOnSave': {
      \     'enable': v:true,
      \     'mode': 'all',
      \   },
      \   'codeAction': {
      \     'disableRuleComment': {
      \       'enable': v:true,
      \       'location': 'separateLine',
      \     },
      \     'showDocumentation': {
      \       'enable': v:true,
      \     },
      \   },
      \   'format': v:false,
      \   'quiet': v:false,
      \   'onIgnoredFiles': 'off',
      \   'options': {},
      \   'run': 'onType',
      \   'nodePath': v:null,
      \ }),
      \ 'semantic_highlight': lsp_settings#get('eslint-language-server', 'semantic_highlight', {}),
      \ }
augroup END
