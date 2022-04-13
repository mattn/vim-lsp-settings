let s:root_dir = expand('<sfile>:h:h')
let s:settings_dir = s:root_dir . '/settings'
let s:checkers_dir = s:root_dir . '/checkers'
let s:installer_dir = s:root_dir . '/installer'

if has('win32')
  let s:data_dir = expand('$LOCALAPPDATA/vim-lsp-settings')
elseif $XDG_DATA_HOME !=# ''
  let s:data_dir = expand('$XDG_DATA_HOME/vim-lsp-settings')
else
  let s:data_dir = expand('~/.local/share/vim-lsp-settings')
endif
let s:servers_dir = s:data_dir . '/servers'

let s:settings = json_decode(join(readfile(s:root_dir . '/settings.json'), "\n"))
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

function! lsp_settings#global_settings_dir() abort
  let l:path = fnamemodify(get(g:, 'lsp_settings_global_settings_dir', s:data_dir), ':p')
  if has('win32')
     let l:path = substitute(l:path, '/', '\', 'g')
  endif
  return substitute(l:path, '[\/]$', '', '')
endfunction

function! lsp_settings#installed_servers() abort
  let l:servers = []
  for l:ft in sort(keys(s:settings))
    for l:conf in s:settings[l:ft]
      let l:path = lsp_settings#servers_dir() . '/' . l:conf.command . '/' . l:conf.command
      if !executable(l:path)
        continue
      endif
      let l:path = lsp_settings#servers_dir() . '/' . l:conf.command . '/.vim-lsp-settings-version'
      let l:version = ''
      if filereadable(l:path)
        let l:version = trim(join(readfile(l:path), "\n"))
      endif
      call add(l:servers, {'name': l:conf.command, 'version': l:version})
    endfor
  endfor
  return l:servers
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
  let l:servers = s:settings[l:ft]
  if empty(l:servers)
    return []
  endif
  if l:ft !=# '_'
    let l:servers += s:settings['_']
  endif

  let l:default = get(g:, 'lsp_settings_filetype_' . a:ft, '')

  let l:name = get(a:000, 0, '')
  for l:conf in l:servers
    if !empty(l:name) && l:conf.command != l:name
      continue
    endif

    if lsp_settings#get(l:conf.command, 'disabled', get(l:conf, 'disabled', 0))
      if !empty(l:name) && l:conf.command == l:name
        call lsp_settings#utils#warning(l:name . ' requested but is disabled by global or local settings')
      endif
      continue
    endif

    if type(l:default) ==# v:t_list
      if len(l:default) ># 0 && index(l:default, l:conf.command) == -1
        if !empty(l:name) && l:conf.command == l:name
          call lsp_settings#utils#warning(l:name . ' requested but is disabled by g:lsp_settings_filetype_' . a:ft)
        endif
        continue
      endif
    elseif type(l:default) ==# v:t_string
      if !empty(l:default) && l:default != l:conf.command
        if !empty(l:name) && l:conf.command == l:name
          call lsp_settings#utils#warning(l:name . ' requested but is disabled by g:lsp_settings_filetype_' . a:ft)
        endif
        continue
      endif
    else
      if !empty(l:name) && l:conf.command == l:name
        call lsp_settings#utils#warning(l:name . ' requested but is disabled by g:lsp_settings_filetype_' . a:ft)
      endif
      continue
    endif

    let l:command = printf('%s/install-%s', s:installer_dir, l:conf.command)
    if has('win32')
      let l:command = substitute(l:command, '/', '\', 'g') . '.cmd'
    else
      let l:command = l:command . '.sh'
    endif
    let l:missing = 0
    for l:require in l:conf.requires
      if !lsp_settings#executable(l:require)
        call lsp_settings#utils#warning(l:conf.command . ' requires ' . l:require)
        let l:missing = 1
        break
      endif
    endfor
    if l:missing !=# 0
      continue
    endif
    if lsp_settings#executable(l:command)
      return [l:conf.command, l:command]
    endif
  endfor
  return [v:false] " placeholder, so that empty() returns false, but len() < 2 returns true
endfunction

function! lsp_settings#server_config(name) abort
  for l:ft in sort(keys(s:settings))
    for l:conf in s:settings[l:ft]
      if l:conf.command ==# a:name && has_key(l:conf, 'config')
        return l:conf['config']
      endif
    endfor
  endfor
  return {}
endfunction

function! lsp_settings#merge(name, key, default) abort
  let l:config = lsp_settings#get(a:name, a:key, {})
  if type(a:default) ==# v:t_func
    return extend(l:config, a:default(a:name, a:key))
  endif
  return lsp_settings#utils#extend(l:config, a:default)
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
  if !has('win32')
    let l:paths .= lsp_settings#servers_dir() . '/' . a:cmd
    return lsp_settings#utils#first_one(globpath(l:paths, a:cmd, 1))
  endif
  let l:paths .= lsp_settings#servers_dir() . '\' . a:cmd
  for l:ext in ['.exe', '.cmd', '.bat']
    let l:path = globpath(l:paths, a:cmd . l:ext, 1)
    if !empty(l:path)
      return lsp_settings#utils#first_one(l:path)
    endif
  endfor
  return ''
endfunction

function! lsp_settings#root_path(patterns) abort
  let l:patterns = extend(copy(a:patterns), g:lsp_settings_root_markers)
  return lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), l:patterns)
endfunction

function! lsp_settings#root_uri(name) abort
  let l:patterns = lsp_settings#get(a:name, 'root_uri_patterns', [])
  if empty(l:patterns)
    for l:ft in sort(keys(s:settings))
      for l:conf in s:settings[l:ft]
        if l:conf.command ==# a:name && has_key(l:conf, 'root_uri_patterns')
          let l:patterns = l:conf['root_uri_patterns']
          break
        endif
      endfor
    endfor
  endif

  let l:dir = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), extend(copy(l:patterns), g:lsp_settings_root_markers))
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
  return filter(uniq(sort(l:installers)), 'stridx(v:val, a:arglead) == 0')
endfunction

function! lsp_settings#complete_install(arglead, cmdline, cursorpos) abort
  let l:installers = []

  for l:ft in split(&filetype . '.', '\.', 1)
    let l:ft = tolower(empty(l:ft) ? '_' : l:ft)
    if !has_key(s:settings, l:ft)
      continue
    endif
    for l:conf in s:settings[l:ft]
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
  endfor
  return filter(uniq(sort(l:installers)), 'stridx(v:val, a:arglead) == 0')
endfunction

function! s:vim_lsp_uninstall_server(command) abort
  if !lsp_settings#utils#valid_name(a:command)
    call lsp_settings#utils#error('Invalid server name')
    return
  endif
  call lsp_settings#utils#msg('Uninstalling ' . a:command)
  let l:server_install_dir = lsp_settings#servers_dir() . '/' . a:command
  if has('win32')
     let l:server_install_dir = substitute(l:server_install_dir, '/', '\', 'g')
  endif
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
        command! -nargs=1 LspRegisterServer autocmd User lsp_setup ++once call lsp_settings#register_server(<args>)
      else
        command! -nargs=1 LspRegisterServer autocmd User lsp_setup call lsp_settings#register_server(<args>)
      endif
      exe 'source' l:script
      delcommand LspRegisterServer
      doautocmd <nomodeline> User lsp_setup
    endif
  endif
  call lsp_settings#utils#msg('Installed ' . a:command)
endfunction

function! lsp_settings#install_server(ft, command) abort
  call s:vim_lsp_install_server(a:ft, a:command, '!')
endfunction

function! s:vim_lsp_install_server(ft, command, bang) abort
  if !empty(a:command) && !lsp_settings#utils#valid_name(a:command)
    call lsp_settings#utils#error('Invalid server name')
    return
  endif
  call lsp#stop_server(a:command)
  let l:entry = s:vim_lsp_installer(a:ft, a:command)
  if empty(l:entry)
    call lsp_settings#utils#error('Server not found')
    return
  endif
  if len(l:entry) < 2
    call lsp_settings#utils#error('Server could not be installed. See :messages for details.')
    return
  endif
  if empty(a:bang) && confirm(printf('Install %s ?', l:entry[0]), "&Yes\n&Cancel") !=# 1
    return
  endif
  let l:server_install_dir = lsp_settings#servers_dir() . '/' . l:entry[0]
  if has('win32')
    let l:server_install_dir = substitute(l:server_install_dir, '/', '\', 'g')
  endif
  if isdirectory(l:server_install_dir)
    call lsp_settings#utils#msg('Uninstalling ' . l:entry[0])
    call delete(l:server_install_dir, 'rf')
  endif
  call mkdir(l:server_install_dir, 'p')
  call lsp_settings#utils#msg('Installing ' . l:entry[0])
  if has('nvim')
    split new
    call termopen([l:entry[1]], {'cwd': l:server_install_dir, 'on_exit': function('s:vim_lsp_install_server_post', [l:entry[0]])}) | startinsert
  else
    let l:bufnr = term_start([l:entry[1]], {'cwd': l:server_install_dir})
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
  if len(l:entry) < 2
    return
  endif
  if lsp_settings#executable(l:entry[0])
    return
  endif

  redraw!
  echohl Directory
  unsilent echomsg 'Please do :LspInstallServer to enable Language Server ' . l:entry[0]
  echohl None
endfunction

function! s:vim_lsp_suggest_plugin() abort
  if &ft != ''
    return
  endif
  let l:ext = expand('%:e')
  for l:ft in keys(s:settings)
    for l:server in s:settings[l:ft]
      if !has_key(l:server, 'vim_plugin')
        continue
      endif
      if index(l:server['vim_plugin']['extensions'], l:ext) == -1
        continue
      endif
      redraw
      echohl Directory
      echomsg printf('Please install vim-plugin "%s" to enable Language Server', l:server['vim_plugin']['name'])
      echohl None
      return
    endfor
  endfor
endfunction

function! lsp_settings#register_server(...) abort
  let l:name = a:000[0]['name']
  let l:env = lsp_settings#get(l:name, 'env', {})
  if !empty(l:env)
    let a:000[0]['env'] = l:env
  endif
  return call('lsp#register_server', a:000)
endfunction

function! s:vim_lsp_load_or_suggest(ft) abort
  if (a:ft !=# '_' && &filetype !=# a:ft) || !has_key(s:settings, a:ft)
    return
  endif

  if filereadable(lsp_settings#global_settings_dir() . '/settings.json')
    let l:settings = json_decode(join(readfile(lsp_settings#global_settings_dir() . '/settings.json'), "\n"))
    if  has_key(g:, 'lsp_settings')
      call extend(g:lsp_settings, l:settings)
    else
      let g:lsp_settings = l:settings
    endif
  endif
  call lsp_settings#profile#load_local()

  if get(g:, 'lsp_loaded', 0)
    for l:server in s:settings[a:ft]
      let l:config = lsp_settings#server_config(l:server.command)
      let l:refresh_pattern = get(l:config, 'refresh_pattern', '')
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
    command! -nargs=1 LspRegisterServer autocmd User lsp_setup ++once call lsp_settings#register_server(<args>)
  else
    command! -nargs=1 LspRegisterServer autocmd User lsp_setup call lsp_settings#register_server(<args>)
  endif

  let l:default = get(g:, 'lsp_settings_filetype_' . a:ft, '')

  let l:found = 0
  let l:disabled = 0

  for l:server in s:settings[a:ft]
    if lsp_settings#get(l:server.command, 'disabled', get(l:server, 'disabled', 0))
      let l:disabled += 1
      continue
    endif

    if type(l:default) ==# v:t_list
      if len(l:default) ># 0 && index(l:default, l:server.command) == -1
        continue
      endif
    elseif type(l:default) ==# v:t_string
      if !empty(l:default) && l:default != l:server.command
        continue
      endif
    else
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

      " If default server is specified as list, continue to look next.
      if type(l:default) !=# v:t_list
        break
      endif
    endif
  endfor

  delcommand LspRegisterServer

  if l:disabled == 0 && l:found ==# 0
    if a:ft !=# '_' && get(g:, 'lsp_settings_enable_suggestions', 1) == 1
      call s:vim_lsp_settings_suggest(a:ft)
    endif
  else
    if exists('#User#lsp_setup') !=# 0
      doautocmd <nomodeline> User lsp_setup
    endif
  endif
endfunction

function! lsp_settings#clear() abort
  let s:ftmap = {}
endfunction

function! lsp_settings#init() abort
  for [l:name, l:server] in items(get(g:, 'lsp_settings', {}))
    if !has_key(l:server, 'allowlist')
      continue
    endif
    for l:ft in l:server['allowlist']
      if !has_key(s:settings, l:ft)
        let s:settings[l:ft] = []
      endif
      let l:found = 0
      for [l:ft2, l:configs] in items(s:settings)
        if l:found || l:ft ==# l:ft2
          continue
        endif
        for l:config in l:configs
          if l:config.command !=# l:name
            continue
          endif
          call add(s:settings[l:ft], l:config)
          let l:found = 1
          break
        endfor
      endfor
    endfor
  endfor

  for l:ft in keys(s:settings)
    if has_key(g:, 'lsp_settings_allowlist') && index(g:lsp_settings_allowlist, l:ft) == -1 || empty(s:settings[l:ft])
      continue
    endif
    exe 'augroup' lsp_settings#utils#group_name(l:ft)
      autocmd!
      exe 'autocmd FileType' l:ft 'call' printf("s:vim_lsp_load_or_suggest('%s')", l:ft)
    augroup END
  endfor
  augroup vim_lsp_suggest
    autocmd!
    autocmd BufNewFile,BufRead * call s:vim_lsp_suggest_plugin()
  augroup END
  command! -nargs=? -complete=customlist,lsp_settings#complete_uninstall LspUninstallServer call s:vim_lsp_uninstall_server(<q-args>)
  command! -bang -nargs=? -complete=customlist,lsp_settings#complete_install LspInstallServer call s:vim_lsp_install_server(&l:filetype, <q-args>, '<bang>')
  call s:vim_lsp_load_or_suggest('_')
endfunction
