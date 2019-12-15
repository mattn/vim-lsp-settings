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

function! lsp_settings#exec_path(cmd) abort
  if executable(a:cmd)
    return a:cmd
  endif
  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',')
  endif
  if !has('win32')
    return !empty(globpath(l:paths, a:cmd))
  endif
  let l:path = globpath(l:paths, a:cmd . '.exe')
  if !empty(l:path)
    return l:path
  endif
  let l:path = globpath(l:paths, a:cmd . '.cmd')
  if !empty(l:path)
    return l:path
  endif
  let l:path = globpath(l:paths, a:cmd . '.bat')
  if !empty(l:path)
    return l:path
  endif
  return ''
endfunction
