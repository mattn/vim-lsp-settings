augroup vim_lsp_settings_jedi_language_server
  au!
  LspRegisterServer {
      \ 'name': 'jedi-language-server',
      \ 'cmd': {server_info->lsp_settings#get('jedi-language-server', 'cmd', [lsp_settings#exec_path('jedi-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('jedi-language-server', 'root_uri', lsp_settings#root_uri('jedi-language-server'))},
      \ 'initialization_options': lsp_settings#get('jedi-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('jedi-language-server', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('jedi-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('jedi-language-server', 'config', lsp_settings#server_config('jedi-language-server')),
      \ 'workspace_config': lsp_settings#get('jedi-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('jedi-language-server', 'semantic_highlight', {}),
      \ }
augroup END
