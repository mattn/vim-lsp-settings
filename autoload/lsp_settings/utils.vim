function! lsp_settings#utils#msg(msg) abort
  redraw
  echohl Comment
  echo a:msg
  echohl None
endfunction

function! lsp_settings#utils#error(msg) abort
  redraw
  echohl Error
  echomsg a:msg
  echohl None
endfunction

function! lsp_settings#utils#valid_name(command) abort
  return a:command =~# '^[a-zA-Z0-9_-]\+$'
endfunction

function! lsp_settings#utils#group_name(ft) abort
  return printf('vim_lsp_suggest_%s', a:ft)
endfunction

function! lsp_settings#utils#first_one(lines) abort
  if empty(a:lines)
    return ''
  endif
  let l:path = fnamemodify(split(a:lines, "\n")[0], ':p')
  if has('win32')
     let l:path = substitute(l:path, '/', '\', 'g')
  endif
  return l:path
endfunction
