let s:servers_dir = expand('<sfile>:h:h').'/servers'

function! lsp_settings#get(name, key, default) abort
  let l:config = get(g:, 'lsp_settings', {})
  if !has_key(l:config, a:name)
    if !has_key(l:config, '*')
      if type(a:default) ==# v:t_func
        return a:default()
      endif
      return a:default
    endif
    let l:config = l:config['*']
  else
    let l:config = l:config[a:name]
  endif
  if !has_key(l:config, a:key)
    if type(a:default) ==# v:t_func
      return a:default()
    endif
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
  let l:paths = []
  if has('win32')
    for l:path in split($PATH, ';')
      if l:path[len(l:path) - 1:] == "\\"
        call add(l:paths, l:path[:len(l:path)-2])
      elseif !empty(l:path)
        call add(l:paths, l:path)
      endif
    endfor
  else
    let l:paths = split($PATH, ':')
  endif
  let l:paths = join(l:paths, ',')
  let l:path = globpath(l:paths, a:cmd)
  if !has('win32')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
  else
    for l:ext in ['.exe', '.cmd', '.bat']
      let l:path = globpath(l:paths, a:cmd . l:ext)
      if !empty(l:path)
        return s:first_one(l:path)
      endif
    endfor
  endif

  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',') . ','
  endif
  let l:servers_dir = get(g:, 'lsp_settings_servers_dir', s:servers_dir)
  let l:paths .= l:servers_dir . '/' . a:cmd
  if !has('win32')
    return s:first_one(globpath(l:paths, a:cmd))
  endif
  for l:ext in ['.exe', '.cmd', '.bat']
    let l:path = globpath(l:paths, a:cmd . l:ext)
    if !empty(l:path)
      return s:first_one(l:path)
    endif
  endfor
  return ''
endfunction

function! lsp_settings#root_uri(pattern) abort
  let l:dir = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), a:pattern)
  if empty(l:dir)
    return lsp#utils#get_default_root_uri()
  endif
  return lsp#utils#path_to_uri(l:dir)
endfunction

function! lsp_settings#autocd(server_info) abort
  if !has_key(a:server_info, 'root_uri')
    return
  endif
  if type(a:server_info['root_uri']) ==# v:t_func
    let l:root_uri = a:server_info['root_uri'](a:server_info)
  else
    let l:root_uri = a:server_info['root_uri']
  endif
  let l:path = lsp#utils#uri_to_path(l:root_uri)
  if isdirectory(l:path)
    exe 'cd' l:path
  endif
endfunction
