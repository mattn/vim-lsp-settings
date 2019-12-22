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
  let l:paths = split($PATH, has('win32') ? ';' : ':')
  let l:paths = join(l:paths, ',')
  let l:path = globpath(l:paths, a:cmd)
  if !has('win32')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
  else
    let l:path = globpath(l:paths, a:cmd . '.exe')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
    let l:path = globpath(l:paths, a:cmd . '.cmd')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
    let l:path = globpath(l:paths, a:cmd . '.bat')
    if !empty(l:path)
      return s:first_one(l:path)
    endif
  endif

  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',')
  endif
  let l:paths .= ',' . s:servers_dir . '/' . a:cmd
  if !has('win32')
    return s:first_one(globpath(l:paths, a:cmd))
  endif
  let l:path = globpath(l:paths, a:cmd . '.exe')
  if !empty(l:path)
    return s:first_one(l:path)
  endif
  let l:path = globpath(l:paths, a:cmd . '.cmd')
  if !empty(l:path)
    return s:first_one(l:path)
  endif
  let l:path = globpath(l:paths, a:cmd . '.bat')
  if !empty(l:path)
    return s:first_one(l:path)
  endif
  return ''
endfunction

function! lsp_settings#register_server_settings(settings) abort
  let settings = a:settings
  if has('patch-8.1.000')
    autocmd User lsp_setup ++once call lsp#register_server(settings)
  else
    autocmd User lsp_setup call lsp#register_server(settings)
  endif
endfunction
