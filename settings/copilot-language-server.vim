augroup vim_lsp_settings_copilot_language_server
  au!
  LspRegisterServer {
      \ 'name': 'copilot-language-server',
      \ 'cmd': {server_info->lsp_settings#get('copilot-language-server', 'cmd', [lsp_settings#exec_path('copilot-language-server')]+lsp_settings#get('copilot-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('copilot-language-server', 'root_uri', lsp_settings#root_uri('copilot-language-server'))},
      \ 'initialization_options': lsp_settings#get('copilot-language-server', 'initialization_options', {"editorInfo": { "name": "GNU ed", "version": "1.19" }, "editorPluginInfo": { "name": "GitHub Copilot for ed", "version": "1.0.0" }}),
      \ 'allowlist': lsp_settings#get('copilot-language-server', 'allowlist', ['*']),
      \ 'blocklist': lsp_settings#get('copilot-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('copilot-language-server', 'config', lsp_settings#server_config('copilot-language-server')),
      \ 'workspace_config': lsp_settings#merge('copilot-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('copilot-language-server', 'semantic_highlight', {}),
      \ }
augroup END

function! s:handle_finish(data) abort
  let l:command = a:data['response']['result']
  echomsg l:command['status']
endfunction

function! s:handle_signin(data) abort
  let l:command = a:data['response']['result']
  call lsp#send_request('copilot-language-server', {
  \   'method': 'workspace/executeCommand',
  \   'params': {'command': 'github.copilot.finishDeviceFlow', 'arguments': []},
  \   'sync': v:false,
  \   'on_notification': function('s:handle_finish'),
  \ })
  redraw
  if get(l:command, 'status') ==# 'AlreadySignedIn'
    echomsg l:command['status']
    return
  endif
  echomsg printf('Set %s on %s', l:command['userCode'], l:command['verificationUri'])
endfunction

function! s:handle_signout(data) abort
  let l:command = a:data['response']['result']
  echomsg l:command['status']
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer -nargs=0 CopilotSignIn call lsp#send_request('copilot-language-server', {
  \   'method': 'signIn',
  \   'params': {},
  \   'sync': v:false,
  \   'on_notification': function('s:handle_signin'),
  \ })
  command! -buffer -nargs=0 CopilotSignOut call lsp#send_request('copilot-language-server', {
  \   'method': 'signOut',
  \   'params': {},
  \   'sync': v:false,
  \   'on_notification': function('s:handle_signout'),
  \ })
endfunction

augroup lsp_install_copilot
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

