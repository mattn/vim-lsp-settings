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

let s:settings_cache = {}
let s:server_config_cache = {}
let s:root_uri_patterns_cache = {}
let s:global_settings_cache = {}
let s:applied_global_settings_key = ''
let s:executable_cache = {}
let s:exec_path_cache = {}

function! s:load_settings() abort
  if empty(s:settings_cache)
    let s:settings_cache = json_decode(join(readfile(s:root_dir . '/settings.json'), "\n"))
    call remove(s:settings_cache, '$schema')
  endif
  return s:settings_cache
endfunction

function! s:rebuild_settings_index() abort
  let s:server_config_cache = {}
  let s:root_uri_patterns_cache = {}
  for l:ft in keys(s:settings)
    for l:conf in s:settings[l:ft]
      if has_key(l:conf, 'config') && !has_key(s:server_config_cache, l:conf.command)
        let s:server_config_cache[l:conf.command] = l:conf.config
      endif
      if has_key(l:conf, 'root_uri_patterns') && !has_key(s:root_uri_patterns_cache, l:conf.command)
        let s:root_uri_patterns_cache[l:conf.command] = l:conf.root_uri_patterns
      endif
    endfor
  endfor
endfunction

let s:settings = s:load_settings()
call s:rebuild_settings_index()

let s:ftmap = {}

function! s:command_cache_key(cmd) abort
  let l:extra_paths = get(g:, 'lsp_settings_extra_paths', '')
  let l:server_dir = lsp_settings#servers_dir() . '/' . a:cmd
  let l:server_command = l:server_dir . '/' . a:cmd
  return join([
        \ a:cmd,
        \ $PATH,
        \ string(l:extra_paths),
        \ l:server_dir,
        \ string(getftime(l:server_dir)),
        \ string(getftime(l:server_command)),
        \ string(getftime(l:server_command . '.exe')),
        \ string(getftime(l:server_command . '.cmd')),
        \ string(getftime(l:server_command . '.bat')),
        \ ], "\n")
endfunction

function! s:clear_command_cache(...) abort
  if a:0 ==# 0
    let s:executable_cache = {}
    let s:exec_path_cache = {}
    return
  endif

  let l:key = s:command_cache_key(a:1)
  call remove(s:executable_cache, l:key)
  call remove(s:exec_path_cache, l:key)
endfunction

function! s:load_global_settings() abort
  let l:path = lsp_settings#global_settings_dir() . '/settings.json'
  if !filereadable(l:path)
    return {'key': '', 'settings': {}}
  endif

  let l:mtime = getftime(l:path)
  let l:key = l:path . ':' . l:mtime
  let l:cache = get(s:global_settings_cache, l:path, {})
  if get(l:cache, 'mtime', -1) ==# l:mtime
    return {'key': l:key, 'settings': l:cache.settings}
  endif

  let l:settings = json_decode(join(readfile(l:path), "\n"))
  let s:global_settings_cache[l:path] = {'mtime': l:mtime, 'settings': l:settings}
  return {'key': l:key, 'settings': l:settings}
endfunction

function! lsp_settings#installer_dir() abort
  return s:installer_dir
endfunction

function! lsp_settings#servers_dir() abort
  let l:path = resolve(fnamemodify(get(g:, 'lsp_settings_servers_dir', s:servers_dir), ':p'))
  let l:path = lsp_settings#utils#normalize_path(l:path)
  return substitute(l:path, '[\/]$', '', '')
endfunction

function! lsp_settings#global_settings_dir() abort
  let l:path = fnamemodify(get(g:, 'lsp_settings_global_settings_dir', s:data_dir), ':p')
  let l:path = lsp_settings#utils#normalize_path(l:path)
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
  let l:key = s:command_cache_key(a:cmd)
  if has_key(s:executable_cache, l:key)
    return s:executable_cache[l:key]
  endif
  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',')
  endif
  let l:paths .= ',' . lsp_settings#servers_dir() . '/' . a:cmd
  if !has('win32')
    let l:found = filter(split(globpath(l:paths, a:cmd, 1), "\n"), 'executable(v:val)')
    let s:executable_cache[l:key] = !empty(l:found)
    return s:executable_cache[l:key]
  endif
  for l:ext in ['.exe', '.cmd', '.bat']
    if !empty(globpath(l:paths, a:cmd . l:ext, 1))
      let s:executable_cache[l:key] = 1
      return 1
    endif
  endfor
  let s:executable_cache[l:key] = 0
  return 0
endfunction

function! s:get_filetype_default(ft) abort
  let l:default = get(g:, 'lsp_settings_filetype_' . a:ft, '')
  if type(l:default) ==# v:t_list && len(l:default) == 1 && type(l:default[0]) == v:t_func
    let l:V = l:default[0]
    try
      let l:default = l:V()
      let g:['lsp_settings_filetype_' . a:ft] = l:default
    catch
      let l:default = ''
    endtry
  endif
  return l:default
endfunction

function! s:is_server_disabled(conf) abort
  return lsp_settings#get(a:conf.command, 'disabled', get(a:conf, 'disabled', 0))
endfunction

function! s:is_server_filtered_by_default(command, default) abort
  if type(a:default) ==# v:t_list
    return len(a:default) ># 0 && index(a:default, a:command) == -1
  elseif type(a:default) ==# v:t_string
    return !empty(a:default) && a:default != a:command
  endif
  return 1
endfunction

function! s:has_missing_requires(conf) abort
  for l:require in a:conf.requires
    if !executable(l:require)
      return 1
    endif
  endfor
  return 0
endfunction

function! s:installer_path(command) abort
  let l:command = printf('%s/install-%s', s:installer_dir, a:command)
  if has('win32')
    return lsp_settings#utils#normalize_path(l:command) . '.cmd'
  endif
  return l:command . '.sh'
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

  let l:default = s:get_filetype_default(a:ft)

  let l:name = get(a:000, 0, '')
  for l:conf in l:servers
    if !empty(l:name) && l:conf.command != l:name
      continue
    endif

    if s:is_server_disabled(l:conf)
      if !empty(l:name) && l:conf.command == l:name
        call lsp_settings#utils#warning(l:name . ' requested but is disabled by global or local settings')
      endif
      continue
    endif

    if s:is_server_filtered_by_default(l:conf.command, l:default)
      if !empty(l:name) && l:conf.command == l:name
        call lsp_settings#utils#warning(l:name . ' requested but is disabled by g:lsp_settings_filetype_' . a:ft)
      endif
      continue
    endif

    let l:command = s:installer_path(l:conf.command)
    if s:has_missing_requires(l:conf)
      if !empty(l:name)
        call lsp_settings#utils#warning(l:conf.command . ' requires ' . join(l:conf.requires, ', '))
      endif
      continue
    endif
    if lsp_settings#executable(l:command)
      return [l:conf.command, l:command]
    endif
  endfor
  return [v:false] " placeholder, so that empty() returns false, but len() < 2 returns true
endfunction

function! lsp_settings#server_config(name) abort
  return get(s:server_config_cache, a:name, {})
endfunction

function! lsp_settings#merge(name, key, default) abort
  let l:config = lsp_settings#get(a:name, a:key, {})
  if type(a:default) ==# v:t_func
    return extend(l:config, a:default(a:name, a:key))
  endif
  return lsp_settings#utils#extend(l:config, a:default)
endfunction

function! lsp_settings#set(name, key, value) abort
  if !has_key(g:, 'lsp_settings')
    let g:lsp_settings = {}
  endif
  if !has_key(g:lsp_settings, a:name)
     let g:lsp_settings[a:name] = {}
  endif
  if !has_key(g:lsp_settings[a:name], a:key)
     let g:lsp_settings[a:name][a:key] = {}
  endif
  let g:lsp_settings[a:name][a:key] = a:value
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
  let l:key = s:command_cache_key(a:cmd)
  if has_key(s:exec_path_cache, l:key)
    return s:exec_path_cache[l:key]
  endif
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
      let s:exec_path_cache[l:key] = lsp_settings#utils#first_one(l:path)
      return s:exec_path_cache[l:key]
    endif
  else
    for l:ext in ['.exe', '.cmd', '.bat']
      let l:path = globpath(l:paths, a:cmd . l:ext, 1)
      if !empty(l:path)
        let s:exec_path_cache[l:key] = lsp_settings#utils#first_one(l:path)
        return s:exec_path_cache[l:key]
      endif
    endfor
  endif

  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',') . ','
  endif
  let l:paths .= lsp_settings#servers_dir() . '/' . a:cmd
  if !has('win32')
    let s:exec_path_cache[l:key] = lsp_settings#utils#first_one(globpath(l:paths, a:cmd, 1))
    return s:exec_path_cache[l:key]
  endif
  for l:ext in ['.exe', '.cmd', '.bat']
    let l:path = globpath(l:paths, a:cmd . l:ext, 1)
    if !empty(l:path)
      let s:exec_path_cache[l:key] = lsp_settings#utils#first_one(l:path)
      return s:exec_path_cache[l:key]
    endif
  endfor
  let s:exec_path_cache[l:key] = ''
  return ''
endfunction

function! lsp_settings#root_path(patterns) abort
  let l:patterns = extend(copy(a:patterns), g:lsp_settings_root_markers)
  return lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), l:patterns)
endfunction

function! lsp_settings#root_uri(name) abort
  let l:patterns = lsp_settings#get(a:name, 'root_uri_patterns', [])
  if empty(l:patterns)
    let l:patterns = get(s:root_uri_patterns_cache, a:name, [])
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

  let l:filetype = getcmdwintype() !=# '' && getcmdtype() ==# '' ? getbufvar('#', '&filetype') : &filetype
  for l:ft in split(l:filetype . '.', '\.', 1)
    let l:ft = tolower(empty(l:ft) ? '_' : l:ft)
    if !has_key(s:settings, l:ft)
      continue
    endif
    for l:conf in s:settings[l:ft]
      if s:has_missing_requires(l:conf)
        continue
      endif
      let l:command = s:installer_path(l:conf.command)
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
  let l:server_install_dir = lsp_settings#utils#normalize_path(lsp_settings#servers_dir() . '/' . a:command)
  if !isdirectory(l:server_install_dir)
    call lsp_settings#utils#error('Server not found')
    return
  endif
  call delete(l:server_install_dir, 'rf')
  call s:clear_command_cache(a:command)
  call lsp_settings#utils#msg('Uninstalled ' . a:command)
endfunction

" neovim passes third argument as 'exit' while vim passes only 2 arguments
function! s:vim_lsp_install_server_post(command, job, code, ...) abort
  if a:code != 0
    return
  endif
  call s:clear_command_cache(a:command)
  if lsp_settings#executable(a:command)
    let l:script = printf('%s/%s.vim', s:settings_dir, a:command)
    if filereadable(l:script)
      command! -nargs=1 LspRegisterServer call lsp_settings#register_server(<args>)
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
  let l:server_install_dir = lsp_settings#utils#normalize_path(lsp_settings#servers_dir() . '/' . l:entry[0])
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

  augroup vim_lsp_settings_suggest
    autocmd!
    exe printf("autocmd VimEnter <buffer> echohl Directory|echomsg 'Please do :LspInstallServer to enable Language Server %s'|echohl None", l:entry[0])
  augroup END
  redraw!
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
  if get(a:000[0], 'deprecated', v:false) ==# v:true
    call lsp_settings#utils#warning(l:name . ' is deprecated')
  endif
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

  let l:global_settings = s:load_global_settings()
  if !empty(l:global_settings.settings) && s:applied_global_settings_key !=# l:global_settings.key
    if has_key(g:, 'lsp_settings')
      call extend(g:lsp_settings, l:global_settings.settings)
    else
      let g:lsp_settings = l:global_settings.settings
    endif
    let s:applied_global_settings_key = l:global_settings.key
  endif
  call lsp_settings#profile#load_local()

  if get(g:, 'lsp_loaded', 0)
    for l:server in s:settings[a:ft]
      let l:config = lsp_settings#server_config(l:server.command)
      let l:refresh_pattern = get(l:config, 'refresh_pattern', '')
      if !empty(l:refresh_pattern)
        let b:asyncomplete_refresh_pattern = l:refresh_pattern
      endif
      let l:refresh_always = get(l:config, 'refresh_always', 0)
      if l:refresh_always
        let b:asyncomplete_refresh_always = l:refresh_always
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

  command! -nargs=1 LspRegisterServer call lsp_settings#register_server(<args>)

  let l:default = s:get_filetype_default(a:ft)

  let l:found = 0
  let l:disabled = 0

  for l:server in s:settings[a:ft]
    if s:is_server_disabled(l:server)
      let l:disabled += 1
      continue
    endif

    if s:is_server_filtered_by_default(l:server.command, l:default)
      continue
    endif

    if s:has_missing_requires(l:server)
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
      " For '_' (all filetypes), always continue to allow multiple servers.
      if a:ft !=# '_' && type(l:default) !=# v:t_list
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
  let s:applied_global_settings_key = ''
  call s:clear_command_cache()
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

  call s:rebuild_settings_index()

  augroup vim_lsp_settings_lazy
    autocmd!
    autocmd FileType * call s:vim_lsp_load_or_suggest(&filetype)
    autocmd BufNewFile,BufRead * call s:vim_lsp_suggest_plugin()
  augroup END
  command! -nargs=? -complete=customlist,lsp_settings#complete_uninstall LspUninstallServer call s:vim_lsp_uninstall_server(<q-args>)
  command! -bang -nargs=? -complete=customlist,lsp_settings#complete_install LspInstallServer call s:vim_lsp_install_server(&l:filetype, <q-args>, '<bang>')
  call s:vim_lsp_load_or_suggest('_')

  if get(g:, 'lsp_settings_lazyload', 0)
    doautocmd BufNewFile,BufEnter
    for l:buf in range(1, bufnr('$'))
      if !bufexists(l:buf) || !bufloaded(l:buf)
        continue
      endif
      call lsp#log_verbose('lsp#ensure_flush_all()', l:buf)
      call lsp#ensure_flush_all(l:buf, lsp#get_allowed_servers(l:buf))
    endfor
  endif
endfunction
