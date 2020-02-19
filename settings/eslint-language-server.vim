augroup vimlsp_settings_eslint_language_server
  au!
  LspRegisterServer {
      \ 'name': 'eslint-language-server',
      \ 'cmd': {server_info->lsp_settings#get('eslint-language-server', 'cmd', [lsp_settings#exec_path('eslint-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('eslint-language-server', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('eslint-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'whitelist': lsp_settings#get('eslint-language-server', 'whitelist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx']),
      \ 'blacklist': lsp_settings#get('eslint-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('eslint-language-server', 'config', lsp_settings#server_config('eslint-language-server')),
      \ 'workspace_config': {
      \   'validate': v:true,
      \   'packageManager': 'npm',
      \   'autoFix': v:true,
      \   'autoFixOnSave': v:true,
      \   'options': {},
      \   'run': 'onType',
      \   'nodePath': v:null,
      \   'quiet': v:false,
      \   'workspaceFolder': v:null,
      \   'codeAction': {
      \     'disableRuleComment': {
      \       'enable': v:true,
      \       'location': 'separateLine'
      \     },
      \     'showDocumentation': {
      \       'enable': v:true
      \     }
      \   }
      \ },
      \ }
augroup END
