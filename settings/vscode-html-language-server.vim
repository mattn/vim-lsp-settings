augroup vim_lsp_settings_vscode_html_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vscode-html-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vscode-html-language-server', 'cmd', [lsp_settings#exec_path('vscode-html-language-server')]+lsp_settings#get('vscode-html-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('vscode-html-langserver', 'root_uri', lsp_settings#root_uri('vscode-html-language-server'))},
      \ 'initialization_options': lsp_settings#get('vscode-html-language-server', 'initialization_options', {'embeddedLanguages': {'css': v:true, 'javascript': v:true}}),
      \ 'allowlist': lsp_settings#get('vscode-html-language-server', 'allowlist', ['html']),
      \ 'blocklist': lsp_settings#get('vscode-html-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('vscode-html-language-server', 'config', lsp_settings#server_config('vscode-html-language-server')),
      \ 'workspace_config': lsp_settings#get('vscode-html-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('vscode-html-language-server', 'semantic_highlight', {}),
      \ }
augroup END
