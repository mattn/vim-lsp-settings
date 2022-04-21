function! LspCheckCommand() abort
  let l:command = trim(filter(systemlist('ros version'), 'v:val =~# "^homedir="')[0][8:], '''"') . '/bin/cl-lsp'
  if !filereadable(l:command)
    return ''
  endif
  call lsp_settings#set('cl-lsp', 'cmd', ['ros', '-Q', '--', l:command])
  return l:command
endfunction
