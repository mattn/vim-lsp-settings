let s:setting_dir = expand('<sfile>:h:h').'/setting'
let s:installer_dir = expand('<sfile>:h:h').'/installer'
let s:setting = json_decode(join(readfile(expand('<sfile>:h:h').'/setting.json'), "\n"))

function! s:executable(cmd) abort
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
  if !empty(globpath(l:paths, a:cmd . '.exe'))
    return 1
  endif
  if !empty(globpath(l:paths, a:cmd . '.cmd'))
    return 1
  endif
  if !empty(globpath(l:paths, a:cmd . '.bat'))
    return 1
  endif
  return 0
endfunction

function! s:vimlsp_installer() abort
  let l:setting = s:setting[&filetype]
  if empty(l:setting)
    return ''
  endif
  let l:found = {}
  for l:conf in l:setting
    let l:missing = 0
    for l:require in l:conf.requires
      if !s:executable(l:require)
        let l:missing = 1
        break
      endif
    endfor
    if l:missing ==# 0
      let l:found = l:conf
      break
    endif
  endfor
  if empty(l:found)
    return ''
  endif
  let l:command = printf('%s/install-%s', s:installer_dir, l:setting[0].command)
  if has('win32')
    let l:command = substitute(l:command, '/', '\', 'g') . '.cmd'
  else
    let l:command = l:command . '.sh'
  endif
  if !s:executable(l:command)
    return ''
  endif
  return l:command
endfunction

function! s:vimlsp_install_server() abort
  let l:command = s:vimlsp_installer()
  exe 'terminal' l:command
endfunction

function! s:vimlsp_settings_suggest() abort
  if empty(s:vimlsp_installer())
    return
  endif
  echomsg printf("If you want to enable Language Server, please do :LspInstallServer")
  command -buffer LspInstallServer call s:vimlsp_install_server()
endfunction

function! s:vimlsp_setting() abort
  for l:ft in keys(s:setting)
    let l:found = 0
    if empty(s:setting[l:ft])
      continue
    endif
    for l:server in s:setting[l:ft]
      if s:executable(l:server.command)
        exe 'source' printf('%s/%s.vim', s:setting_dir, l:server.command)
        let l:found += 1
        break
      endif
    endfor
    if l:found ==# 0
      exe printf('augroup vimlsp_suggest_%s', l:ft)
        au!
        exe printf('autocmd FileType %s call s:vimlsp_settings_suggest()', l:ft)
      augroup END
    endif
  endfor
endfunction

call s:vimlsp_setting()
