call lsp_settings#register_server({
    \ 'name': 'lake',
    \ 'cmd': {server_info->lsp_settings#get('lake', 'cmd', [lsp_settings#exec_path('lake')]+lsp_settings#get('lake', 'args', ['serve']))},
    \ 'root_uri':{server_info->lsp_settings#get('lake', 'root_uri', lsp_settings#root_uri('lake'))},
    \ 'initialization_options': lsp_settings#get('lake', 'initialization_options', v:null),
    \ 'allowlist': lsp_settings#get('lake', 'allowlist', ['lean']),
    \ 'blocklist': lsp_settings#get('lake', 'blocklist', []),
    \ 'config': lsp_settings#get('lake', 'config', lsp_settings#server_config('lake')),
    \ 'workspace_config': lsp_settings#get('lake', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('lake', 'semantic_highlight', {}),
    \ })

let s:goal_bufnr = -1

function! s:goal_winnr() abort
  return bufexists(s:goal_bufnr) ? bufwinnr(s:goal_bufnr) : -1
endfunction

function! s:show_goal(lines) abort
  let l:curwin = win_getid()
  let l:winnr = s:goal_winnr()
  if l:winnr != -1
    execute l:winnr . 'wincmd w'
  elseif bufexists(s:goal_bufnr)
    execute 'silent botright vertical' get(g:, 'lsp_settings_lean_goal_width', 50) . 'split'
    execute 'silent buffer' s:goal_bufnr
  else
    execute 'silent botright vertical' get(g:, 'lsp_settings_lean_goal_width', 50) . 'new'
    let s:goal_bufnr = bufnr('%')
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    setlocal nonumber norelativenumber nolist winfixwidth
    silent file Lean\ Goal
    let b:lsp_settings_lean_goal = 1
    setlocal filetype=lean
  endif
  setlocal modifiable
  silent %delete _
  call setline(1, a:lines)
  setlocal nomodifiable
  call win_gotoid(l:curwin)
endfunction

function! s:handle_goal(silent, data) abort
  if lsp#client#is_error(a:data['response'])
    if !a:silent
      call lsp#utils#error('Failed to retrieve goal: ' . lsp#client#error_message(a:data['response']))
    endif
    return
  endif
  let l:result = get(a:data['response'], 'result', v:null)
  if type(l:result) != v:t_dict || empty(get(l:result, 'goals', []))
    if a:silent && s:goal_winnr() == -1
      return
    endif
    call s:show_goal(['No goals'])
    return
  endif
  let l:lines = []
  for l:goal in l:result['goals']
    if !empty(l:lines)
      call add(l:lines, '')
    endif
    let l:lines += split(l:goal, "\n")
  endfor
  call s:show_goal(l:lines)
endfunction

function! s:request_goal(silent) abort
  if &filetype !=# 'lean' || exists('b:lsp_settings_lean_goal')
    return
  endif
  call lsp#send_request('lake', {
      \ 'method': '$/lean/plainGoal',
      \ 'params': {
      \   'textDocument': lsp#get_text_document_identifier(),
      \   'position': lsp#get_position(),
      \ },
      \ 'on_notification': function('s:handle_goal', [a:silent]),
      \ })
endfunction

function! s:toggle_goal_follow() abort
  let b:lsp_settings_lean_goal_follow = !get(b:, 'lsp_settings_lean_goal_follow', 0)
  if b:lsp_settings_lean_goal_follow
    call s:request_goal(0)
  else
    let l:winnr = s:goal_winnr()
    if l:winnr != -1
      execute l:winnr . 'close'
    endif
  endif
endfunction

function! s:on_lsp_buffer_enabled() abort
  if &filetype !=# 'lean' || exists('b:lsp_settings_lean_goal')
    return
  endif
  command! -buffer LspLeanGoal call <SID>request_goal(0)
  command! -buffer LspLeanGoalToggle call <SID>toggle_goal_follow()
  nnoremap <buffer> <plug>(lsp-lean-goal) :<c-u>call <SID>request_goal(0)<cr>
  nnoremap <buffer> <plug>(lsp-lean-goal-toggle) :<c-u>call <SID>toggle_goal_follow()<cr>
  augroup vim_lsp_settings_lake_buffer
    au! * <buffer>
    autocmd CursorHold,CursorHoldI <buffer>
        \ if get(b:, 'lsp_settings_lean_goal_follow', 0) | call s:request_goal(1) | endif
  augroup END
endfunction

augroup vim_lsp_settings_lake
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
