let s:servers_dir = expand('<sfile>:h:h').'/servers'
let s:installer_dir = expand('<sfile>:h:h').'/installer'
let s:root_dir = expand('<sfile>:h:h')

function! lsp_settings#get(name, key, default) abort
  let l:config = get(g:, 'lsp_settings', {})
  if !has_key(l:config, a:name)
    if !has_key(l:config, '*')
      if type(a:default) ==# v:t_func
        return a:default(a:name, a:key)
      endif
      return a:default
    endif
    let l:config = l:config['*']
  else
    let l:config = l:config[a:name]
  endif
  if !has_key(l:config, a:key)
    if type(a:default) ==# v:t_func
      return a:default(a:name, a:key)
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

function! lsp_settings#complete_uninstall(arglead, cmdline, cursorpos) abort
  let l:settings = json_decode(join(readfile(s:root_dir . '/settings.json'), "\n"))
  call remove(l:settings, '$schema')

  let l:servers_dir = get(g:, 'lsp_settings_servers_dir', s:servers_dir)
  let l:installers = []
  for l:ft in keys(l:settings)
    for l:conf in l:settings[l:ft]
      if !isdirectory(l:servers_dir . '/' . l:conf.command)
        continue
      endif
      call add(l:installers, l:conf.command)
    endfor
  endfor
  return filter(uniq(l:installers), 'stridx(v:val, a:arglead) == 0')
endfunction

function! lsp_settings#complete_install(arglead, cmdline, cursorpos) abort
  let l:settings = json_decode(join(readfile(s:root_dir . '/settings.json'), "\n"))
  call remove(l:settings, '$schema')

  let l:ft = tolower(get(split(&filetype, '\.'), 0, ''))
  if !has_key(l:settings, l:ft)
    return []
  endif
  let l:server = l:settings[l:ft]
  if empty(l:server)
    return []
  endif
  let l:installers = []
  for l:conf in l:server
    let l:missing = 0
    for l:require in l:conf.requires
      if !executable(l:require)
        let l:missing = 1
        break
      endif
    endfor
    if l:missing !=# 0
      continue
    endif
    let l:command = printf('%s/install-%s', s:installer_dir, l:conf.command)
    if has('win32')
      let l:command = substitute(l:command, '/', '\', 'g') . '.cmd'
    else
      let l:command = l:command . '.sh'
    endif
    if executable(l:command)
      call add(l:installers, l:conf.command)
    endif
  endfor
  return filter(uniq(l:installers), 'stridx(v:val, a:arglead) == 0')
endfunction
