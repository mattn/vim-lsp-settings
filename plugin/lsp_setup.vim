let s:setting_dir = expand('<sfile>:h:h').'/setting'
let s:installer_dir = expand('<sfile>:h:h').'/installer'
let s:setting = json_decode(join(readfile(expand('<sfile>:h:h').'/setting.json'), "\n"))

function! s:vimlsp_installer()
  if empty(s:setting[&filetype])
    return ''
  endif
  let l:command = printf('%s/install-%s', s:installer_dir, s:setting[&filetype][0].command)
  if has('win32')
    let l:command = substitute(l:command, '/', '\', 'g') . '.cmd'
  else
    let l:command = l:command . '.sh'
  endif
  if !executable(l:command)
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
      if executable(l:server.command)
        exe 'source' printf('%s/%s.vim', s:setting_dir, l:server.command)
        let l:found += 1
        break
      endif
    endfor
    if l:found == 0
	  exe printf('augroup vimlsp_suggest_%s', l:ft)
	    au!
	    exe printf('autocmd FileType %s call s:vimlsp_settings_suggest()', l:ft)
	  augroup END
    endif
  endfor
endfunction

call s:vimlsp_setting()
