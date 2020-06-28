function! lsp_settings#profile#load_local() abort
  try
    let l:root = lsp#utils#find_nearest_parent_directory('.', '.vim-lsp-settings')
    if !empty(l:root) && filereadable(l:root . '/settings.json')
      let l:settings = json_decode(join(readfile(l:root . '/settings.json'), "\n"))
      if  has_key(g:, 'lsp_settings')
        for [l:k, l:v] in items(l:settings)
          if has_key(g:lsp_settings, l:k)
            let g:lsp_settings[l:k] = extend(g:lsp_settings[l:k], l:v)
          else
            let g:lsp_settings[l:k] = l:v
          endif
        endfor
      else
        let g:lsp_settings = l:settings
      endif
    endif
  catch
  endtry
endfunction

function! lsp_settings#profile#edit_global() abort
  let l:root = lsp_settings#data_dir()
  if !isdirectory(l:root)
    call mkdir(l:root)
  endif
  exe 'new' l:root . '/settings.json'
  if !filereadable(l:root . '/settings.json')
    call setline(1, ['{', "\t", '}'])
    call cursor([2, 2])
    setlocal nomodified
  endif
endfunction

function! lsp_settings#profile#edit_local(...) abort
  let l:root = ''
  if a:0 >= 1
    let l:root = a:1
  endif
  if l:root ==# ''
    let l:root = lsp_settings#root_path(['.vim-lsp-settings'])
  endif
  if !isdirectory(l:root)
    return
  endif
  let l:root .= '/.vim-lsp-settings'
  if !isdirectory(l:root)
    call mkdir(l:root)
  endif
  exe 'new' l:root . '/settings.json'
  if !filereadable(l:root . '/settings.json')
    call setline(1, ['{', "\t", '}'])
    call cursor([2, 2])
    setlocal nomodified
  endif
endfunction

let s:color_map = {
\ 'exited': 'Error',
\ 'starting': 'MoreMsg',
\ 'failed': 'WarningMsg',
\ 'running': 'Keyword',
\ 'not running': 'NonText'
\}

function! lsp_settings#profile#status() abort
  let l:settings = lsp_settings#settings()
  let l:active_servers = lsp#get_allowed_servers()

  let l:servers = []
  for l:ft in keys(l:settings)
    for l:v in l:settings[l:ft]
      if index(l:servers, l:v.command) ==# -1
        call add(l:servers, l:v.command)
      endif
    endfor
  endfor

  for l:server in uniq(sort(l:servers))
    if index(l:active_servers, l:server) != -1
      let l:status = lsp#get_server_status(l:server)
      echon l:server . ': '
      exec 'echohl' s:color_map[l:status]
      echon l:status
      echohl None
      let l:server_info = lsp#get_server_info(l:server)
      for [l:k, l:V] in items(l:server_info)
        echo printf('  %s: %s', l:k, string(l:V))
      endfor
    endif
    echo ''
  endfor
endfunction
