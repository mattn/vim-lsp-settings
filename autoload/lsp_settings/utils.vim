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

function! s:merge(lhs, rhs) abort
  let [l:lhs, l:rhs] = [a:lhs, a:rhs]
  if type(l:lhs) ==# 3
    if type(l:rhs) ==# 3
      let l:lhs += l:rhs
      if len(l:lhs)
        call remove(l:lhs, 0, len(l:lhs)-1)
      endif
      for l:rhi in l:rhs
        call add(l:lhs, l:rhs[l:rhi])
      endfor
    elseif type(l:rhs) ==# 4
      let l:lhs += map(keys(l:rhs), '{v:val : l:rhs[v:val]}')
    endif
  elseif type(l:lhs) ==# 4
    if type(l:rhs) ==# 3
      for l:V in l:rhs
        if type(l:V) != 4
          continue
        endif
        for l:k in keys(l:V)
          let l:lhs[l:k] = l:V[l:k]
        endfor
      endfor
    elseif type(l:rhs) ==# 4
      for l:key in keys(l:rhs)
        if type(l:rhs[l:key]) ==# 3
          if !has_key(l:lhs, l:key)
            let l:lhs[l:key] = []
          endif
          if type(l:lhs[l:key]) == 3
            let l:lhs[l:key] += l:rhs[l:key]
          elseif type(l:lhs[l:key]) == 4
            for l:k in keys(l:rhs[l:key])
              let l:lhs[l:key][l:k] = l:rhs[l:key][l:k]
            endfor
          endif
        elseif type(l:rhs[l:key]) ==# 4
          if has_key(l:lhs, l:key)
            call s:merge(l:lhs[l:key], l:rhs[l:key])
          else
            let l:lhs[l:key] = l:rhs[l:key]
          endif
        else
          let l:lhs[l:key] = l:rhs[l:key]
        endif
      endfor
    endif
  endif
endfunction

function! lsp_settings#utils#merge(d) abort
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
    call s:merge(l:ret, l:new)
  endfor
  return l:ret
endfunction
