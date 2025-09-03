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

function! s:handle_execute_command(data) abort
  echom json_encode(a:data)
  "if lsp#client#is_error(a:data['response'])
  "  call lsp#utils#error('Execute command failed on ' . a:server_name . ': ' . string(a:command) . ' -> ' . string(a:data))
  "endif
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer -nargs=0 CopilotFinishDeviceFlow call lsp#send_request('copilot-language-server', {
  \   'method': 'workspace/executeCommand',
  \   'params': {'command': 'github.copilot.finishDeviceFlow', 'arguments': []},
  \   'sync': v:false,
  \   'on_notification': function('s:handle_execute_command'),
  \ })
  command! -buffer -nargs=0 CopilotSignIn call lsp#send_request('copilot-language-server', {
  \   'method': 'workspace/executeCommand',
  \   'params': {'command': 'github.copilot.signIn', 'arguments': []},
  \   'sync': v:false,
  \   'on_notification': function('s:handle_execute_command'),
  \ })

endfunction

augroup lsp_install_copilot
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

