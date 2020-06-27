augroup vim_lsp_settings_sqls
  au!
  LspRegisterServer {
      \ 'name': 'sqls',
      \ 'cmd': {server_info->lsp_settings#get('sqls', 'cmd', [lsp_settings#exec_path('sqls')])},
      \ 'root_uri':{server_info->lsp_settings#get('sqls', 'root_uri', lsp_settings#root_uri('sqls'))},
      \ 'initialization_options': lsp_settings#get('sqls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('sqls', 'allowlist', ['sql']),
      \ 'blocklist': lsp_settings#get('sqls', 'blocklist', []),
      \ 'config': lsp_settings#get('sqls', 'config', lsp_settings#server_config('sqls')),
      \ 'workspace_config': lsp_settings#get('sqls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('sqls', 'semantic_highlight', {}),
      \ }
augroup END

function! s:sqls_query() abort
  call lsp#send_request('sqls', {
    \ 'method': 'workspace/executeCommand',
    \ 'params': {
    \   'command': 'sqls.executeQuery',
    \   'arguments': [lsp#utils#get_buffer_uri()],
    \ },
    \ 'on_notification': function('s:handle_execute_command'),
    \ })
endfunction

function! s:handle_execute_command(data) abort
  let l:lines = a:data['response']['result']
  vnew
  call setline(1, split(l:lines, "\n"))
endfunction

function! s:on_lsp_buffer_enabled() abort
  if &ft !=# 'sql'
    return
  endif
  command! -buffer LspSQLQuery call <SID>sqls_query()
endfunction

augroup lsp_install_sqls
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
