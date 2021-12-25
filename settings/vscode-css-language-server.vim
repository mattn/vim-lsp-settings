augroup vim_lsp_settings_vscode_css_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vscode-css-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vscode-css-language-server', 'cmd', [lsp_settings#exec_path('vscode-css-language-server')]+lsp_settings#get('vscode-css-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('vscode-css-language-server', 'root_uri', lsp_settings#root_uri('vscode-css-language-server'))},
      \ 'initialization_options': lsp_settings#get('vscode-css-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('vscode-css-language-server', 'allowlist', ['css', 'less', 'sass', 'scss']),
      \ 'blocklist': lsp_settings#get('vscode-css-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('vscode-css-language-server', 'config', lsp_settings#server_config('vscode-css-language-server')),
      \ 'workspace_config': lsp_settings#get('vscode-css-language-server', 'workspace_config', {
      \   'css': {'lint': {'validProperties': []}},
      \   'less': {'lint': {'validProperties': []}},
      \   'sass': {'lint': {'validProperties': []}},
      \   'scss': {'lint': {'validProperties': []}},
      \ }),
      \ 'semantic_highlight': lsp_settings#get('vscode-css-language-server', 'semantic_highlight', {}),
      \ }
augroup END
