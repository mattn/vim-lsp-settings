augroup vimlsp_settings_cobol_language_support
  au!
  LspRegisterServer {
      \ 'name': 'cobol-language-support',
      \ 'cmd': {server_info->lsp_settings#get('cobol-language-support', 'cmd', [lsp_settings#exec_path('cobol-language-support')])},
      \ 'root_uri':{server_info->lsp_settings#get('cobol-language-server', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('cobol-language-support', 'initialization_options', {}),
      \ 'whitelist': lsp_settings#get('cobol-language-support', 'whitelist', ['cobol']),
      \ 'blacklist': lsp_settings#get('cobol-language-support', 'blacklist', []),
      \ 'config': lsp_settings#get('cobol-language-support', 'config', lsp_settings#server_config('cobol-language-support')),
      \ 'workspace_config': lsp_settings#get('cobol-language-support', 'workspace_config', {}),
      \ }
augroup END
