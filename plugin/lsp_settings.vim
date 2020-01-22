if exists('g:loaded_lsp_settings') || !exists('*json_encode') || !has('lambda')
  finish
endif
let g:loaded_lsp_settings= 1

let s:settings_dir = expand('<sfile>:h:h').'/settings'
let s:checkers_dir = expand('<sfile>:h:h').'/checkers'
let s:installer_dir = expand('<sfile>:h:h').'/installer'
let s:servers_dir = expand('<sfile>:h:h').'/servers'
let s:settings = json_decode(join(readfile(expand('<sfile>:h:h').'/settings.json'), "\n"))

function! s:executable(cmd) abort
  if executable(a:cmd)
    return 1
  endif
  let l:paths = get(g:, 'lsp_settings_extra_paths', '')
  if type(l:paths) == type([])
    let l:paths = join(l:paths, ',')
  endif
  let l:servers_dir = get(g:, 'lsp_settings_servers_dir', s:servers_dir)
  let l:paths .= ',' . l:servers_dir . '/' . a:cmd
  if !has('win32')
    return !empty(globpath(l:paths, a:cmd))
  endif
  for l:ext in ['.exe', '.cmd', '.bat']
    if !empty(globpath(l:paths, a:cmd . l:ext))
      return 1
    endif
  endfor
  return 0
endfunction

function! s:vimlsp_installer() abort
  let l:ft = tolower(split(&filetype, '\.')[0])
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
    return []
  endif
  for l:conf in l:server
    let l:command = s:vimlsp_settings_get(l:conf.command, 'cmd', l:conf.command)
    if type(l:command) == type([])
      let l:command = l:command[0]
    endif
    let l:command = printf('%s/install-%s', s:installer_dir, l:command)
    if has('win32')
      let l:command = substitute(l:command, '/', '\', 'g') . '.cmd'
    else
      let l:command = l:command . '.sh'
    endif
    if s:executable(l:command)
      return [l:conf.command, l:command]
    endif
  endfor
  return []
endfunction

" neovim passes third argument as 'exit' while vim passes only 2 arguments
function! s:vimlsp_install_server_post(command, job, code, ...) abort
  if a:code != 0
    return
  endif
  if s:executable(a:command)
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
endfunction

function! s:vimlsp_install_server() abort
  let l:entry = s:vimlsp_installer()
  if empty(l:entry)
    return
  endif
  let l:servers_dir = get(g:, 'lsp_settings_servers_dir', s:servers_dir)
  let l:server_install_dir = l:servers_dir . '/' . l:entry[0]
  if isdirectory(l:server_install_dir)
    call delete(l:server_install_dir, 'rf')
  endif
  call mkdir(l:server_install_dir, 'p')
  if has('nvim')
    split new
    call termopen(l:entry[1], {'cwd': l:server_install_dir, 'on_exit': function('s:vimlsp_install_server_post', [l:entry[0]])}) | startinsert
  else
    let l:bufnr = term_start(l:entry[1], {'cwd': l:server_install_dir})
    let l:job = term_getjob(l:bufnr)
    if l:job != v:null
      call job_setoptions(l:job, {'exit_cb': function('s:vimlsp_install_server_post', [l:entry[0]])})
    endif
  endif
endfunction

function! s:vimlsp_settings_suggest() abort
  if empty(s:vimlsp_installer())
    return
  endif
  if exists(':LspInstallServer') !=# 2
    redraw
    echohl Directory
    echomsg 'If enable Language Server, please do :LspInstallServer'
    echohl None
    command! -buffer LspInstallServer call s:vimlsp_install_server()
  endif
endfunction

function! s:vimlsp_settings_get(name, key, default) abort
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

function! s:vimlsp_setting() abort
  for l:ft in keys(s:settings)
    if has_key(g:, 'lsp_settings_whitelist') && index(g:lsp_settings_whitelist, l:ft) == -1 || empty(s:settings[l:ft])
      continue
    endif
    exe 'augroup' s:load_or_suggest_group_name(l:ft)
      au!
      exe 'autocmd FileType' l:ft 'call s:vimlsp_load_or_suggest(' string(l:ft) ')'
    augroup END
  endfor
  augroup vimlsp_suggest
    au!
    autocmd BufNewFile,BufRead * call s:vimlsp_suggest_plugin()
  augroup END
endfunction

function! s:vimlsp_suggest_plugin() abort
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
      echomsg printf('If enable Language Server, please install vim-plugin "%s"', l:server['vim-plugin']['name'])
      echohl None
      return
    endfor
  endfor
endfunction

function! s:vimlsp_load_or_suggest(ft) abort
  let l:group_name = s:load_or_suggest_group_name(a:ft)
  exe 'augroup' l:group_name
    au!
  augroup END
  exe 'augroup!' l:group_name

  if has('patch-8.1.1113')
    command! -nargs=1 LspRegisterServer autocmd User lsp_setup ++once call lsp#register_server(<args>)
  else
    command! -nargs=1 LspRegisterServer autocmd User lsp_setup call lsp#register_server(<args>)
  endif

  let l:found = 0

  for l:server in s:settings[a:ft]
    if s:vimlsp_settings_get(l:server.command, 'disabled', 0)
      continue
    endif
    let l:command = s:vimlsp_settings_get(l:server.command, 'cmd', l:server.command)
    if type(l:command) == type([])
      let l:command = l:command[0]
    endif
    if !s:executable(l:command)
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
      break
    endif
  endfor

  if l:found ==# 0
    call s:vimlsp_settings_suggest()
  else
    doautocmd User lsp_setup
    if exists(':LspInstallServer') !=# 2
      command! -buffer LspInstallServer call s:vimlsp_install_server()
    endif
  endif

  if exists(':LspRegisterServer') !=# 2
    delcommand LspRegisterServer
  endif
endfunction

function! s:load_or_suggest_group_name(ft) abort
  return printf('vimlsp_suggest_%s', a:ft)
endfunction

call s:vimlsp_setting()
