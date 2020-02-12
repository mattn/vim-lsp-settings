let s:settings_dir = expand('<sfile>:h:h') . '/settings'
let s:checkers_dir = expand('<sfile>:h:h') . '/checkers'
let s:servers_dir = expand('<sfile>:h:h') . '/servers'
let s:installer_dir = expand('<sfile>:h:h') . '/installer'
let s:root_dir = expand('<sfile>:h:h')

let s:settings = json_decode(join(readfile(expand('<sfile>:h:h') . '/settings.json'), "\n"))
call remove(s:settings, '$schema')

let s:ftmap = {}

function! lsp_settings#installer_dir() abort
  return s:installer_dir
endfunction

function! lsp_settings#servers_dir() abort
  let l:path = fnamemodify(get(g:, 'lsp_settings_servers_dir', s:servers_dir), ':p')
  if has('win32')
     let l:path = substitute(l:path, '/', '\', 'g')
  endif
  return substitute(l:path, '[\/]$', '', '')
endfunction

function! lsp_settings#executable(cmd) abort
  if executable(a:cmd)
    return 1
  endif
  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',')
  endif
  let l:paths .= ',' . lsp_settings#servers_dir() . '/' . a:cmd
  if !has('win32')
    let l:found = globpath(l:paths, a:cmd, 1)
    return !empty(l:found)
  endif
  for l:ext in ['.exe', '.cmd', '.bat']
    if !empty(globpath(l:paths, a:cmd . l:ext, 1))
      return 1
    endif
  endfor
  return 0
endfunction

function! s:vim_lsp_installer(ft, ...) abort
  let l:ft = tolower(get(split(a:ft, '\.'), 0, ''))
  let l:ft = empty(l:ft) ? '_' : l:ft
  if !has_key(s:settings, l:ft)
    return []
  endif
  let l:server = s:settings[l:ft]
  if empty(l:server)
    return []
  endif
  let l:found = {}
  for l:conf in l:server
    let l:missing = 0
    for l:require in l:conf.requires
      if !lsp_settings#executable(l:require)
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
    return []
  endif
  let l:name = get(a:000, 0, '')
  for l:conf in l:server
    if !empty(l:name) && l:conf.command != l:name
      continue
    endif
    let l:command = printf('%s/install-%s', s:installer_dir, l:conf.command)
    if has('win32')
      let l:command = substitute(l:command, '/', '\', 'g') . '.cmd'
    else
      let l:command = l:command . '.sh'
    endif
    if lsp_settings#executable(l:command)
      return [l:conf.command, l:command]
    endif
  endfor
  return []
endfunction

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
  if type(l:config[a:key]) == v:t_func
    return l:config[a:key](a:name, a:key)
  endif
  return l:config[a:key]
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
  let l:path = globpath(l:paths, a:cmd, 1)
  if !has('win32')
    if !empty(l:path)
      return lsp_settings#utils#first_one(l:path)
    endif
  else
    for l:ext in ['.exe', '.cmd', '.bat']
      let l:path = globpath(l:paths, a:cmd . l:ext, 1)
      if !empty(l:path)
        return lsp_settings#utils#first_one(l:path)
      endif
    endfor
  endif

  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',') . ','
  endif
  let l:paths .= lsp_settings#servers_dir() . '/' . a:cmd
  if !has('win32')
    return lsp_settings#utils#first_one(globpath(l:paths, a:cmd, 1))
  endif
  for l:ext in ['.exe', '.cmd', '.bat']
    let l:path = globpath(l:paths, a:cmd . l:ext, 1)
    if !empty(l:path)
      return lsp_settings#utils#first_one(l:path)
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

function! lsp_settings#settings() abort
  return s:settings
endfunction

function! lsp_settings#complete_uninstall(arglead, cmdline, cursorpos) abort
  let l:installers = []
  for l:ft in sort(keys(s:settings))
    for l:conf in s:settings[l:ft]
      if !isdirectory(lsp_settings#servers_dir() . '/' . l:conf.command)
        continue
      endif
      call add(l:installers, l:conf.command)
    endfor
  endfor
  return filter(uniq(l:installers), 'stridx(v:val, a:arglead) == 0')
endfunction

function! lsp_settings#complete_install(arglead, cmdline, cursorpos) abort
  let l:ft = tolower(get(split(&filetype, '\.'), 0, ''))
  let l:ft = empty(l:ft) ? '_' : l:ft
  if !has_key(s:settings, l:ft)
    return []
  endif
  let l:server = s:settings[l:ft]
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

function! s:vim_lsp_uninstall_server(command) abort
  if !lsp_settings#utils#valid_name(a:command)
    call lsp_settings#utils#error('Invalid server name')
    return
  endif
  call lsp_settings#utils#msg('Uninstalling ' . a:command)
  let l:server_install_dir = lsp_settings#servers_dir() . '/' . a:command
  if !isdirectory(l:server_install_dir)
    call lsp_settings#utils#error('Server not found')
    return
  endif
  call delete(l:server_install_dir, 'rf')
  call lsp_settings#utils#msg('Uninstalled ' . a:command)
endfunction

" neovim passes third argument as 'exit' while vim passes only 2 arguments
function! s:vim_lsp_install_server_post(command, job, code, ...) abort
  if a:code != 0
    return
  endif
  if lsp_settings#executable(a:command)
    let l:script = printf('%s/%s.vim', s:settings_dir, a:command)
    if filereadable(l:script)
      if has('patch-8.1.1113')
        command! -nargs=1 LspRegisterServer autocmd User lsp_setup ++once call lsp#register_server(<args>)
      else
        command! -nargs=1 LspRegisterServer autocmd User lsp_setup call lsp#register_server(<args>)
      endif
      exe 'source' l:script
      delcommand LspRegisterServer
      doautocmd User lsp_setup
    endif
  endif
  call lsp_settings#utils#msg('Installed ' . a:command)
endfunction

function! s:vim_lsp_install_server(ft, command) abort
  if !empty(a:command) && !lsp_settings#utils#valid_name(a:command)
    call lsp_settings#utils#error('Invalid server name')
    return
  endif
  let l:entry = s:vim_lsp_installer(a:ft, a:command)
  if empty(l:entry)
    call lsp_settings#utils#error('Server not found')
    return
  endif
  let l:server_install_dir = lsp_settings#servers_dir() . '/' . l:entry[0]
  if isdirectory(l:server_install_dir)
    call lsp_settings#utils#msg('Uninstalling ' . l:entry[0])
    call delete(l:server_install_dir, 'rf')
  endif
  call mkdir(l:server_install_dir, 'p')
  call lsp_settings#utils#msg('Installing ' . l:entry[0])
  if has('nvim')
    split new
    call termopen(l:entry[1], {'cwd': l:server_install_dir, 'on_exit': function('s:vim_lsp_install_server_post', [l:entry[0]])}) | startinsert
  else
    let l:bufnr = term_start(l:entry[1], {'cwd': l:server_install_dir})
    let l:job = term_getjob(l:bufnr)
    if l:job != v:null
      call job_setoptions(l:job, {'exit_cb': function('s:vim_lsp_install_server_post', [l:entry[0]])})
    endif
  endif
endfunction

function! s:vim_lsp_settings_suggest(ft) abort
  let l:entry = s:vim_lsp_installer(a:ft)
  if empty(l:entry)
    return
  endif

  redraw!
  echohl Directory
  echomsg 'Please do :LspInstallServer to enable Language Server ' . l:entry[0]
  echohl None
  if exists(':LspInstallServer') !=# 2
    command! -nargs=? -buffer -complete=customlist,lsp_settings#complete_install LspInstallServer call s:vim_lsp_install_server(&l:filetype, <q-args>)
  endif
endfunction

function! s:vim_lsp_suggest_plugin() abort
  if &ft != ''
    return
  endif
  let l:ext = expand('%:e')
  for l:ft in keys(s:settings)
    for l:server in s:settings[l:ft]
      if !has_key(l:server, 'vim-plugin')
        continue
      endif
      if index(l:server['vim-plugin']['extensions'], l:ext) == -1
        continue
      endif
      redraw
      echohl Directory
      echomsg printf('Please install vim-plugin "%s" to enable Language Server', l:server['vim-plugin']['name'])
      echohl None
      return
    endfor
  endfor
endfunction

function! s:vim_lsp_load_or_suggest_delay(ft) abort
  if get(g:, 'vim_lsp_settings_filetype_no_delays', 0)
    return s:vim_lsp_load_or_suggest(a:ft)
  endif
  call timer_start(0, {timer -> [s:vim_lsp_load_or_suggest(a:ft), execute('doautocmd BufReadPost')]})
endfunction

function! s:vim_lsp_load_or_suggest(ft) abort
  if (a:ft !=# '_' && &filetype !=# a:ft) || !has_key(s:settings, a:ft)
    return
  endif

  if get(g:, 'lsp_loaded', 0)
    for l:server in s:settings[a:ft]
      let l:refresh_pattern = get(l:server, 'refresh_pattern', '')
      if !empty(l:refresh_pattern)
        let b:asyncomplete_refresh_pattern = l:refresh_pattern
      endif
    endfor
  endif

  if get(s:ftmap, a:ft, 0)
    return
  endif
  let l:group_name = lsp_settings#utils#group_name(a:ft)
  exe 'augroup' l:group_name
    autocmd!
  augroup END
  exe 'augroup!' l:group_name

  if has('patch-8.1.1113')
    command! -nargs=1 LspRegisterServer autocmd User lsp_setup ++once call lsp#register_server(<args>)
  else
    command! -nargs=1 LspRegisterServer autocmd User lsp_setup call lsp#register_server(<args>)
  endif

  let l:found = 0
  let l:disabled = 0

  for l:server in s:settings[a:ft]
    if lsp_settings#get(l:server.command, 'disabled', get(l:server, 'disabled', 0))
      let l:disabled += 1
      continue
    endif
    let l:default = get(g:, 'lsp_settings_' . a:ft, '')
    if !empty(l:default) && l:default != l:server.command
      continue
    endif
    let l:command = lsp_settings#get(l:server.command, 'cmd', [])
    if empty(l:command) && !lsp_settings#executable(l:server.command)
      let l:script = printf('%s/%s.vim', s:checkers_dir, l:server.command)
      if !filereadable(l:script) || has_key(l:server, 'fallback')
        continue
      endif
      let l:server['fallback'] = ''
      try
        exe 'source' l:script
        let l:command = LspCheckCommand()
        let l:server['fallback'] = l:command
      catch
      finally
        if exists('*LspCheckCommand')
          delfunction LspCheckCommand
        endif
        if empty(l:server['fallback'])
          continue
        endif
      endtry
    endif
    let l:script = printf('%s/%s.vim', s:settings_dir, l:server.command)
    if filereadable(l:script)
      exe 'source' l:script
      let l:found += 1
      let s:ftmap[a:ft] = 1
      break
    endif
  endfor

  if l:disabled == 0 && l:found ==# 0
    call s:vim_lsp_settings_suggest(a:ft)
  else
    if exists('#User#lsp_setup') !=# 0
      doautocmd User lsp_setup
    endif
    if exists(':LspInstallServer') !=# 2
      command! -nargs=? -buffer -complete=customlist,lsp_settings#complete_install LspInstallServer call s:vim_lsp_install_server(&l:filetype, <q-args>)
    endif
  endif

  if exists(':LspRegisterServer') !=# 2
    delcommand LspRegisterServer
  endif
endfunction

function! lsp_settings#clear() abort
  let s:ftmap = {}
endfunction

function! lsp_settings#init() abort
  for l:ft in keys(s:settings)
    if has_key(g:, 'lsp_settings_whitelist') && index(g:lsp_settings_whitelist, l:ft) == -1 || empty(s:settings[l:ft])
      continue
    endif
    exe 'augroup' lsp_settings#utils#group_name(l:ft)
      autocmd!
      exe 'autocmd FileType' l:ft 'call' printf("s:vim_lsp_load_or_suggest_delay('%s')", l:ft)
    augroup END
  endfor
  augroup vim_lsp_suggest
    autocmd!
    autocmd BufNewFile,BufRead * call s:vim_lsp_suggest_plugin()
  augroup END
  command! -nargs=? -complete=customlist,lsp_settings#complete_uninstall LspUninstallServer call s:vim_lsp_uninstall_server(<q-args>)
  call s:vim_lsp_load_or_suggest('_')
endfunction
