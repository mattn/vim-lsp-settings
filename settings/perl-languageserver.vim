augroup vimlsp_settings_perl_languageserver
  au!
  LspRegisterServer {
      \ 'name': 'perl-languageserver',
      \ 'cmd': {server_info->lsp_settings#get('perl-languageserver', 'cmd', ['perl', '-MPerl::LanguageServer', '-e', 'Perl::LanguageServer->run'])},
      \ 'root_uri':{server_info->lsp_settings#get('perl-languageserver', 'root_uri', lsp_settings#root_uri('perl-languageserver'))},
      \ 'initialization_options': lsp_settings#get('perl-languageserver', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('perl-languageserver', 'whitelist', ['perl']),
      \ 'blacklist': lsp_settings#get('perl-languageserver', 'blacklist', []),
      \ 'config': lsp_settings#get('perl-languageserver', 'config', lsp_settings#server_config('perl-languageserver')),
      \ 'workspace_config': lsp_settings#get('perl-languageserver', 'workspace_config', {}),
      \ }
augroup END
