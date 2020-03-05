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

function! lsp_settings#utils#dotmerge(d) abort
  let l:ret = {}
  let l:keys = keys(a:d)
  for l:k in sort(keys(a:d))
    let l:new = {}
    let l:cur = l:new
    let l:arr = split(l:k, '\.')
    for l:i in range(len(l:arr))
      let l:kk = l:arr[l:i]
      if type(l:cur) == v:t_dict && !has_key(l:cur, l:kk)
        if l:i == len(l:arr) - 1
          let l:cur[l:kk] = a:d[l:k]
          break
        else
          let l:cur[l:kk] = {}
        endif
      endif
      let l:cur = l:cur[l:kk]
    endfor
    let l:ret = extend(l:ret, l:new)
  endfor
  return l:ret
endfunction
