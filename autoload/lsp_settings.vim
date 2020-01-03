let s:servers_dir = expand('<sfile>:h:h').'/servers'

function! lsp_settings#get(name, key, default) abort
  let l:config = get(g:, 'lsp_settings', {})
  if !has_key(l:config, a:name)
    if !has_key(l:config, '*')
      return a:default
    endif
    let l:config = l:config['*']
  else
    let l:config = l:config[a:name]
  endif
  if !has_key(l:config, a:key)
    return a:default
  endif
  return l:config[a:key]
endfunction

function! s:first_one(cmd) abort
  if empty(a:cmd)
    return ''
  endif
  return fnamemodify(split(a:cmd, "\n")[0], ':p')
endfunction

function! lsp_settings#exec_path(cmd) abort
  let l:s = split(a:cmd, ':')
  let l:dir = len(l:s) >= 1 ? l:s[0] : ''
  let l:cmd = len(l:s) >= 2 ? l:s[1] : l:s[0]

  let l:paths = split($PATH, has('win32') ? ';' : ':')
  let l:paths = join(l:paths, ',')
  let l:path = globpath(l:paths, l:cmd)
  if !has('win32')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
  else
    let l:path = globpath(l:paths, l:cmd . '.exe')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
    let l:path = globpath(l:paths, l:cmd . '.cmd')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
    let l:path = globpath(l:paths, l:cmd . '.bat')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
  endif

  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',') . ','
  endif
  let l:servers_dir = get(g:, 'lsp_settings_servers_dir', s:servers_dir)
  let l:paths .= l:servers_dir . '/' . l:dir
  if !has('win32')
    return s:first_one(globpath(l:paths, l:cmd))
  endif
  let l:path = globpath(l:paths, l:cmd . '.exe')
  if !empty(l:path)
    return s:first_one(l:path)
  endif
  let l:path = globpath(l:paths, l:cmd . '.cmd')
  if !empty(l:path)
    return s:first_one(l:path)
  endif
  let l:path = globpath(l:paths, l:cmd . '.bat')
  if !empty(l:path)
    return s:first_one(l:path)
  endif
  return ''
endfunction

function! lsp_settings#root_uri(pattern) abort
  let l:dir = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), a:pattern)
  if empty(l:dir)
    return lsp#utils#get_default_root_uri()
  endif
  return lsp#utils#path_to_uri(l:dir)
endfunction
