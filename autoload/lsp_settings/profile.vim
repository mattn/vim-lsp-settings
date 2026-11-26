function! s:filter_deny_keys(settings) abort
  let l:deny_keys = get(g:, 'lsp_settings_deny_local_keys', ['cmd'])
  if empty(l:deny_keys)
    return
  endif
  for l:setting in values(a:settings)
    if v:t_dict !=# type(l:setting)
      continue
    endif
    for l:v in values(l:setting)
      if v:t_dict !=# type(l:v)
        continue
      endif
      for l:deny in l:deny_keys
        if has_key(l:v, l:deny)
          call remove(l:v, l:deny)
        endif
      endfor
    endfor
  endfor
endfunction

function! lsp_settings#profile#load_local() abort
  try
    let l:dir = expand('%:p:h')
    let l:root = finddir('.vim-lsp-settings', l:dir . ';')
    if empty(l:root)
      return
    endif
    if !filereadable(l:root . '/settings.json')
      return
    endif
    let l:settings = json_decode(join(readfile(l:root . '/settings.json'), "\n"))
    call s:filter_deny_keys(l:settings)
    if has_key(g:, 'lsp_settings')
      for [l:k, l:v] in items(l:settings)
        if has_key(g:lsp_settings, l:k)
          let g:lsp_settings[l:k] = lsp_settings#utils#extend(g:lsp_settings[l:k], l:v)
        else
          let g:lsp_settings[l:k] = l:v
        endif
      endfor
    else
      let g:lsp_settings = l:settings
    endif
  catch
  endtry
endfunction

function! lsp_settings#profile#edit_global() abort
  let l:root = lsp_settings#global_settings_dir()
  if !isdirectory(l:root)
    call mkdir(l:root, 'p')
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
    let l:root = lsp_settings#root_path(['.vim-lsp-settings/'])
  endif
  if empty(l:root)
    let l:root = getcwd()
  endif
  if !isdirectory(l:root)
    return
  endif
  let l:root .= '/.vim-lsp-settings'
  if !isdirectory(l:root)
    call mkdir(l:root, 'p')
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
\ 'not running': 'NonText',
\ 'unknown server': 'NonText',
\}

function! lsp_settings#profile#status() abort
  let l:active_servers = sort(lsp#get_allowed_servers())
  if empty(l:active_servers)
    echo printf("No language server is registered for filetype '%s'", &filetype)
  endif

  let l:procs = {}
  for l:server in l:active_servers
    let l:status = lsp#get_server_status(l:server)
    if l:status ==# 'running' && empty(l:procs)
      let l:procs = s:process_table()
    endif
    echo l:server . ': '
    exec 'echohl' get(s:color_map, l:status, 'None')
    echon l:status
    echohl None
    call s:server_details(l:server, l:status, l:procs)
  endfor

  let l:others = filter(sort(lsp#get_server_names()), 'index(l:active_servers, v:val) ==# -1')
  if !empty(l:others)
    echo 'Registered for other filetypes: ' . join(l:others, ', ')
  endif
  echo 'Log file: ' . (empty(get(g:, 'lsp_log_file', '')) ? 'off (set g:lsp_log_file)' : g:lsp_log_file)
endfunction

" With a third argument, cuts the value to the window width, or to 120
" characters in a narrower window.
function! s:field(label, value, ...) abort
  let l:value = a:value
  let l:width = max([&columns - 16, 120])
  if a:0 && strchars(l:value) > l:width
    let l:value = strcharpart(l:value, 0, l:width - 1) . '…'
  endif
  echohl Identifier
  echo printf('  %-11s ', a:label)
  echohl None
  echon l:value
endfunction

" { pid: {'ppid': N, 'secs': N, 'args': S} } for every process, from one
" `ps` call.  `etimes` (elapsed seconds) is procps-only: fall back to
" without it.
function! s:process_table() abort
  if has('win32') || !executable('ps')
    return {}
  endif
  let l:procs = {}
  let l:out = system('ps -e -o pid=,ppid=,etimes=,args=')
  let l:pattern = '^\s*\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\)\s\+\(.*\)$'
  if v:shell_error
    let l:out = system('ps -e -o pid=,ppid=,args=')
    let l:pattern = '^\s*\(\d\+\)\s\+\(\d\+\)\s\+\(\)\(.*\)$'
  endif
  for l:line in split(l:out, "\n")
    let l:m = matchlist(l:line, l:pattern)
    if !empty(l:m)
      let l:procs[l:m[1]] = {'ppid': l:m[2], 'secs': l:m[3], 'args': l:m[4]}
    endif
  endfor
  return l:procs
endfunction

function! s:children(procs, pid) abort
  return sort(filter(keys(a:procs), 'a:procs[v:val].ppid ==# a:pid'), 'N')
endfunction

" The binary a process runs, when /proc shows one other than its argv[0].
function! s:exe(pid, args) abort
  if !isdirectory('/proc/' . a:pid)
    return ''
  endif
  let l:link = '/proc/' . a:pid . '/exe'
  let l:exe = resolve(l:link)
  return l:exe ==# l:link || l:exe ==# get(split(a:args), 0, '') ? '' : l:exe
endfunction

function! s:elapsed(secs) abort
  if a:secs ==# ''
    return ''
  endif
  let l:s = str2nr(a:secs)
  if l:s < 60
    return printf(' (%ds)', l:s)
  elseif l:s < 3600
    return printf(' (%dm%02ds)', l:s / 60, l:s % 60)
  endif
  return printf(' (%dh%02dm)', l:s / 3600, l:s % 3600 / 60)
endfunction

function! s:print_process_tree(procs, pid, depth, budget) abort
  if a:budget[0] <= 0
    return
  endif
  let a:budget[0] -= 1
  let l:indent = repeat('  ', a:depth)
  let l:proc = a:procs[a:pid]
  call s:field(a:depth ==# 0 ? 'process' : '',
  \ l:indent . 'pid ' . a:pid . s:elapsed(l:proc.secs) . '  ' . l:proc.args, 1)
  let l:exe = s:exe(a:pid, l:proc.args)
  if !empty(l:exe)
    call s:field('', l:indent . '  exe ' . l:exe, 1)
  endif
  for l:child in s:children(a:procs, a:pid)
    call s:print_process_tree(a:procs, l:child, a:depth + 1, a:budget)
  endfor
endfunction

function! s:server_details(server, status, procs) abort
  let l:info = lsp#get_server_info(a:server)

  call s:field('filetypes', join(get(l:info, 'allowlist', get(l:info, 'whitelist', [])), ', '))

  let l:cmd = []
  if has_key(l:info, 'tcp')
    call s:field('tcp', l:info.tcp)
  elseif has_key(l:info, 'cmd')
    try
      let l:cmd = type(l:info.cmd) ==# v:t_func ? l:info.cmd(l:info) : l:info.cmd
    catch
      call s:field('cmd', 'error: ' . v:exception)
    endtry
    if type(l:cmd) ==# v:t_list && !empty(l:cmd)
      call s:field('cmd', match(l:cmd, '\s') ==# -1 ? join(l:cmd, ' ') : json_encode(l:cmd))
      let l:exe = exepath(l:cmd[0])
      let l:where = empty(l:exe) ? 'not found' : resolve(l:exe)
      if !empty(l:exe) && stridx(l:where, lsp_settings#servers_dir()) ==# 0
        let l:where .= '  (installed by vim-lsp-settings)'
      endif
      call s:field('executable', l:where)
    else
      let l:cmd = []
    endif
  endif
  if !empty(get(l:info, 'env', {}))
    call s:field('env', join(map(items(l:info.env), {_, kv -> kv[0] . '=' . kv[1]}), ' '))
  endif

  if a:status !=# 'running'
    return
  endif

  if !get(g:, 'lsp_work_done_progress_enabled', 0)
    call s:field('progress', 'not reported (set g:lsp_work_done_progress_enabled = 1 before vim-lsp loads)')
  else
    let l:progress = filter(copy(lsp#get_progress()), {_, p -> p.server ==# a:server})
    if empty(l:progress)
      call s:field('progress', 'idle')
    endif
    for l:p in l:progress
      call s:field('progress', l:p.title
      \ . (empty(l:p.message) ? '' : ': ' . l:p.message)
      \ . (has_key(l:p, 'percentage') ? printf(' (%d%%)', l:p.percentage) : ''))
    endfor
  endif

  if exists('*lsp#get_server_pid')
    let l:pid = string(lsp#get_server_pid(a:server))
    if has_key(a:procs, l:pid)
      call s:print_process_tree(a:procs, l:pid, 0, [12])
    elseif l:pid !=# '0'
      call s:field('process', 'pid ' . l:pid)
    endif
  else
    " vim-lsp before lsp#get_server_pid(): match Vim's child processes to the
    " command, whose argv[0] a `sh -c '... exec server'` wrapper replaces.
    let l:words = split(substitute(join(l:cmd, ' '), '[''"]', ' ', 'g'))
    let l:found = 0
    for l:pid in s:children(a:procs, string(getpid()))
      if index(l:words, get(split(a:procs[l:pid].args), 0, '')) !=# -1
        call s:print_process_tree(a:procs, l:pid, 0, [12])
        let l:found = 1
      endif
    endfor
    if !l:found && !empty(a:procs)
      call s:field('process', 'no child process of Vim matches cmd')
    endif
  endif

  call s:field('root', lsp#get_server_root_uri(a:server))

  let l:providers = []
  for [l:key, l:Value] in sort(items(lsp#get_server_capabilities(a:server)))
    if l:key =~# 'Provider$' && l:Value isnot v:false && !empty(l:Value)
      call add(l:providers, substitute(l:key, 'Provider$', '', ''))
    endif
  endfor
  call s:field('providers', join(l:providers, ' '))
endfunction

function! lsp_settings#profile#servers() abort
  let l:settings = lsp_settings#settings()
  let l:active_servers = lsp#get_allowed_servers()

  let l:servers = {}
  for l:ft in keys(l:settings)
    for l:v in l:settings[l:ft]
      if lsp_settings#executable(l:v.command)
        let l:servers[l:v.command] = 1
      endif
    endfor
  endfor
  for l:server in keys(l:servers)
    echo l:server
  endfor
endfunction
