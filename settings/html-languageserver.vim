augroup vimlsp_settings_html_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'html-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('html-languageserver', 'cmd', [lsp_settings#exec_path('html-languageserver'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('html-langserver', 'root_uri', lsp_settings#root_uri(['.git/']))},
      \ 'initialization_options': lsp_settings#get('html-languageserver', 'initialization_options', {'provideFormatter': v:true, 'embeddedLanguages': {'css': v:true, 'html': v:true}}),
      \ 'whitelist': lsp_settings#get('html-languageserver', 'whitelist', ['html']),
      \ 'blacklist': lsp_settings#get('html-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('html-languageserver', 'config', {}),
      \ 'workspace_config': lsp_settings#get('html-languageserver', 'workspace_config', {}),
      \ }
augroup END
