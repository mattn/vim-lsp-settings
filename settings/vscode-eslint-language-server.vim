augroup vim_lsp_settings_eslint_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vscode-eslint-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vscode-eslint-language-server', 'cmd', [lsp_settings#exec_path('vscode-eslint-language-server')]+lsp_settings#get('vscode-eslint-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('vscode-eslint-language-server', 'root_uri', lsp_settings#root_uri('vscode-eslint-language-server'))},
      \ 'initialization_options': lsp_settings#get('vscode-eslint-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('vscode-eslint-language-server', 'allowlist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact']),
      \ 'blocklist': lsp_settings#get('vscode-eslint-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('vscode-eslint-language-server', 'config', lsp_settings#server_config('vscode-eslint-language-server')),
      \ 'workspace_config': lsp_settings#get('vscode-eslint-language-server', 'workspace_config', {
      \   'validate': 'probe',
      \   'packageManager': 'npm',
      \   'useESLintClass': v:false,
      \   'experimental': { 'useFlatConfig': v:false },
      \   'codeAction': {
      \     'disableRuleComment': {
      \       'enable': v:true,
      \       'location': 'separateLine',
      \     },
      \     'showDocumentation': {
      \       'enable': v:true,
      \     },
      \   },
      \   'codeActionOnSave': {
      \     'enable': v:true,
      \     'mode': 'all',
      \   },
      \   'format': v:false,
      \   'quiet': v:false,
      \   'onIgnoredFiles': 'off',
      \   'options': {},
      \   'rulesCustomizations': [],
      \   'run': 'onType',
      \   'problems': { 'shortenToSingleLine': v:true },
      \   'nodePath': v:null,
      \ }),
      \ 'semantic_highlight': lsp_settings#get('vscode-eslint-language-server', 'semantic_highlight', {}),
      \ }
augroup END
