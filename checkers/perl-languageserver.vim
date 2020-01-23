function! LspCheckCommand() abort
  call system('perl -e "use Perl::LanguageServer"')
  if v:shell_error
    return ''
  endif
  return 'perl -MPerl::LanguageServer -e "Perl::LanguageServer->run"'
endfunction
