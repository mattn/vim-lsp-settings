let s:setting_dir = expand('<sfile>:h:h').'/setting'
let s:setting = json_decode(join(readfile(expand('<sfile>:h:h').'/setting.json'), "\n"))

function! s:vimlsp_settings_suggest(cmd) abort
  echomsg "Do you install " . a:cmd
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
	    exe printf('autocmd FileType %s call s:vimlsp_settings_suggest(%s)', l:ft, string(s:setting[l:ft][0].command))
	  augroup END
    endif
  endfor
endfunction

call s:vimlsp_setting()
