function! LspCheckCommand() abort
  let l:command = trim(filter(systemlist('ros version'), 'v:val =~# "^homedir="')[0][8:], '''"') . '/bin/cl-lsp'
  if filereadable(l:command)
    return l:command
  endif
  return ''
endfunction
