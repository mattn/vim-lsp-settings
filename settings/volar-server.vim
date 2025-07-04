augroup vim_lsp_settings_volar_server
  au!
  LspRegisterServer {
  \ 'name': 'volar-server',
  \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
  \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
  \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', v:null),
  \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue', 'typescript']),
  \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
  \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
  \ }
augroup END

function s:on_tsserver_request(id, data) abort
  let body = a:data['response']['result']['body']

  call lsp#callbag#pipe(
    \ lsp#notification('volar-server', {
    \   'method': 'tsserver/response',
    \   'params': [[a:id, body]]
    \ }),
    \ lsp#callbag#subscribe()
    \ )
endfunction

function s:on_notification(server_name, data) abort
  if a:server_name ==# 'volar-server' && a:data['response']['method'] ==# 'tsserver/request'
    let [id, command, payload] = a:data['response']['params'][0]

    call lsp#send_request('vtsls', {
    \ 'method': 'workspace/executeCommand',
    \ 'params': {
    \   'command': 'typescript.tsserverRequest',
    \   'arguments': [command, payload],
    \  },
    \ 'on_notification': function('s:on_tsserver_request', [id]),
    \ })
  endif
endfunction

function! s:on_lsp_buffer_enabled() abort
  " Force some capabilities to be enabled.
  " These capabilities are expected to be registered by dynamic registration
  " by vim-lsp, but are registered statically by volar.
  " cf. https://github.com/prabirshrestha/vim-lsp/pull/1379
  let l:capabilities = lsp#get_server_capabilities('volar-server')
  if !empty(l:capabilities)
    let l:capabilities.callHierarcyProvider = v:true
    let l:capabilities.renameProvider = {'prepareProvider': v:true}
    let l:capabilities.signatureHelpProvider = v:true
    let l:capabilities.workspaceSymbolProvider = v:true
  endif

  " Connect to vtsls server
  " cf. https://github.com/vuejs/language-tools/wiki/Neovim
  call lsp#register_notifications('volar-server', function('s:on_notification'))

  " check vtsls installation
  let vtsls_server_dir = lsp_settings#servers_dir() .. '/vtsls'
  if !isdirectory(vtsls_server_dir)
    call lsp_settings#utils#warning('Please install vtsls to enable Vue support')
  endif

  if !exists('g:lsp_settings_filetype_vue') ||
  \ index(g:lsp_settings_filetype_vue, 'volar-server') == -1 ||
  \ index(g:lsp_settings_filetype_vue, 'vtsls') == -1
    call lsp_settings#utils#warning('Add both ''volar-server'' and ''vtsls'' to g:lsp_settings_filetype_vue to enable Vue support')
  endif

  if !exists('g:lsp_settings_filetype_typescript') ||
  \ index(g:lsp_settings_filetype_vue, 'vtsls') == -1
    call lsp_settings#utils#warning('Set ''vtsls'' to g:lsp_settings_filetype_typescript to enable Vue support')
  endif
endfunction

augroup lsp_install_volar_server
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
