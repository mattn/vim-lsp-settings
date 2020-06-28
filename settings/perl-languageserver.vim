augroup vim_lsp_settings_perl_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'perl-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('perl-languageserver', 'cmd', ['perl', '-MPerl::LanguageServer', '-e', 'Perl::LanguageServer->run'])},
      \ 'root_uri':{server_info->lsp_settings#get('perl-languageserver', 'root_uri', lsp_settings#root_uri('perl-languageserver'))},
      \ 'initialization_options': lsp_settings#get('perl-languageserver', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('perl-languageserver', 'allowlist', ['perl']),
      \ 'blocklist': lsp_settings#get('perl-languageserver', 'blocklist', []),
      \ 'config': lsp_settings#get('perl-languageserver', 'config', lsp_settings#server_config('perl-languageserver')),
      \ 'workspace_config': lsp_settings#get('perl-languageserver', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('perl-languageserver', 'semantic_highlight', {}),
      \ }
augroup END
