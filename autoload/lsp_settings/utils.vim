function! lsp_settings#utils#msg(msg, ...) abort
  redraw
  echohl Comment
  echo a:msg
  echohl None
  return a:0 > 0 ? a:000[0] : v:null
endfunction

function! lsp_settings#utils#warning(msg, ...) abort
  redraw
  echohl WarningMsg
  echomsg a:msg
  echohl None
  return a:0 > 0 ? a:000[0] : v:null
endfunction

function! lsp_settings#utils#error(msg, ...) abort
  redraw
  echohl Error
  echomsg a:msg
  echohl None
  return a:0 > 0 ? a:000[0] : v:null
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

let s:catalog_path = expand('<sfile>:h:h:h') . '/data/catalog.json'

function! lsp_settings#utils#load_schemas(name) abort
  let l:schemas = json_decode(join(readfile(s:catalog_path), "\n"))['schemas']
  return extend(l:schemas, lsp_settings#get(a:name, 'schemas', []))
endfunction

function! lsp_settings#utils#load_schemas_map(name) abort
  let l:schemas = json_decode(join(readfile(s:catalog_path), "\n"))['schemas']
  let l:result = {}
  for l:v in extend(l:schemas, lsp_settings#get(a:name, 'schemas', []))
    if has_key(l:v, 'fileMatch')
      let l:result[l:v['url']] = l:v['fileMatch']
    endif
  endfor
  return l:result
endfunction

function! lsp_settings#utils#term_start(cmd, options) abort
    let l:options = {}
    if has_key(a:options, 'cwd')
        let l:options['cwd'] = a:options['cwd']
    endif
    if has('nvim')
        split new
        call termopen(a:cmd, l:options)
    else
        call term_start(a:cmd, l:options)
    endif
endfunction

function! s:extend(lhs, rhs) abort
  let [l:lhs, l:rhs] = [a:lhs, a:rhs]
  if type(l:lhs) ==# 3
    if type(l:rhs) ==# 3
      " [1,2,3]+[4,5,6]=[1,2,3,4,5,6]
      let l:lhs += l:rhs
    elseif type(l:rhs) ==# 4
      " [1,2,3]+{'a':1,'b':2}= [1,2,3,{'a':1},{'b':2}]
      let l:lhs += map(keys(l:rhs), '{v:val : l:rhs[v:val]}')
    endif
  elseif type(l:lhs) ==# 4
    if type(l:rhs) ==# 3
      " {'a':1,'b':2}+[{'c':3},{'d':4},5]= {'a':1,'b':2,'c':3,'d':4}
      for l:V in l:rhs
        if type(l:V) != 4
          continue
        endif
        for l:k in keys(l:V)
          let l:lhs[l:k] = l:V[l:k]
        endfor
      endfor
    elseif type(l:rhs) ==# 4
      " {'a':1,'b':2}+{'c':3,'d':4}= {'a':1,'b':2,'c':3,'d':4}
      for l:key in keys(l:rhs)
        if type(l:rhs[l:key]) ==# 3
          " {'a':1,'b':2}+{'c':[1]}={'a':1,'b':2,'c':[1]}
          if !has_key(l:lhs, l:key)
            let l:lhs[l:key] = []
          endif
          if type(l:lhs[l:key]) == 3
            " {'a':[1],'b':2}+{'a':[2]}={'a':[1,2],'b':2}
            let l:lhs[l:key] += l:rhs[l:key]
          elseif type(l:lhs[l:key]) == 4
            " {'a':{'aa':1},'b':2}+{'a':[2]}={'a':[2],'b':2}
            for l:k in keys(l:rhs[l:key])
              let l:lhs[l:key][l:k] = l:rhs[l:key][l:k]
            endfor
          endif
        elseif type(l:rhs[l:key]) ==# 4
          " {'a':{'aa':1},'b':2}+{'a':{'ab':2]}={'a':{'aa':1,'ab':2},'b':2}
          if has_key(l:lhs, l:key)
            call s:extend(l:lhs[l:key], l:rhs[l:key])
          else
            let l:lhs[l:key] = l:rhs[l:key]
          endif
        else
          " {'a':{'aa':1},'b':2}+{'a':1}={'a':1,'b':2}
          let l:lhs[l:key] = l:rhs[l:key]
        endif
      endfor
    endif
  endif
  return l:lhs
endfunction

function! lsp_settings#utils#extend(lhs, rhs) abort
  return s:extend(a:lhs, a:rhs)
endfunction

function! lsp_settings#utils#shellescape(path) abort
  let l:quote = &shellxquote ==# '"' ?  "'" : '"'
  return l:quote . a:path . l:quote
endfunction

function! lsp_settings#utils#open_url(url) abort
    if exists('g:loaded_openbrowser') && g:loaded_openbrowser
      call openbrowser#open(a:url)
    elseif has('win32') || has('win64')
      silent! exec printf('!start rundll32 url.dll,FileProtocolHandler %s', a:url)
    elseif has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin'
      call system(printf('open "%s"', a:url))
    elseif executable('xdg-open')
      call system(printf('xdg-open "%s"', a:url))
    elseif executable('firefox')
      call system(printf('firefox "%s"', a:url))
    else
      return v:false
    endif
    return v:true
endfunction
