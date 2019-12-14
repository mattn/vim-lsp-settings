let s:setting_dir = expand('<sfile>:h:h').'/setting'
let s:setting = json_decode(join(readfile(expand('<sfile>:h:h').'/setting.json'), "\n"))

function! s:vimlsp_setting() abort
  for l:ft in keys(s:setting)
    for l:command in keys(s:setting[l:ft])
      if executable(l:command)
        exe 'source' printf('%s/%s.vim', s:setting_dir, l:command)
      endif
    endfor
  endfor
endfunction

call s:vimlsp_setting()
