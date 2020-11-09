augroup vim_lsp_settings_texlab
  au!
  LspRegisterServer {
      \ 'name': 'texlab',
      \ 'cmd': {server_info->lsp_settings#get('texlab', 'cmd', [lsp_settings#exec_path('texlab')])},
      \ 'root_uri':{server_info->lsp_settings#get('texlab', 'root_uri', lsp_settings#root_uri('texlab'))},
      \ 'initialization_options': lsp_settings#get('texlab', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('texlab', 'allowlist', ['plaintex', 'tex']),
      \ 'blocklist': lsp_settings#get('texlab', 'blocklist', []),
      \ 'config': lsp_settings#get('texlab', 'config', lsp_settings#server_config('texlab')),
      \ 'workspace_config': lsp_settings#get('texlab', 'workspace_config', {
      \   'latex': {'build': {'args': []}}
      \ }),
      \ 'semantic_highlight': lsp_settings#get('texlab', 'semantic_highlight', {}),
      \ }
augroup END

let s:build_status_success = 0
let s:build_status_error = 1
let s:build_status_failure = 2
let s:build_status_cancelled = 3

function! s:handle_document_build(ctx, server, type, has_extension, data) abort "ctx = {counter, list, last_command_id}
  if a:ctx['last_command_id'] != lsp#_last_command()
    return
  endif

  if lsp#client#is_error(a:data['response']) || !has_key(a:data['response'], 'result')
    call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': ' . lsp#client#error_message(a:data['response']))
    return
  elseif type(a:data['response']['result']) !=# v:t_dict || !has_key(a:data['response']['result'], 'status')
    call lsp#utils#error('No buildable document found')
    return
  endif
  let l:status = a:data['response']['result']['status']
  if l:status ==# s:build_status_success
    echomsg 'Build success'
  elseif l:status ==# s:build_status_cancelled
    echomsg 'Build canceled'
  elseif l:status ==# s:build_status_error
    call lsp#utils#error('Build process terminated with errors')
  elseif l:status ==# s:build_status_failure
    call lsp#utils#error('Build process failed to start or crashed')
  endif
endfunction

function! s:document_build() abort
  let l:servers = lsp#get_whitelisted_servers()

  let l:has_extension = 0
  for l:server in l:servers
    if stridx(l:server, 'texlab') != -1
      let l:has_extension += 1
    endif
  endfor

  if l:has_extension == 0
    call lsp#utils#error('Building document not supported for '.&filetype)
    return
  endif

  let l:command_id = lsp#_new_command()
  let l:ctx = { 'counter': l:has_extension, 'list':[], 'last_command_id': l:command_id }
  for l:server in l:servers
    if stridx(l:server, 'texlab') == -1
      continue
    endif

    call lsp#send_request(l:server, {
      \ 'method': 'textDocument/build',
      \ 'params': {
      \   'textDocument': lsp#get_text_document_identifier()
      \ },
      \ 'on_notification': function('s:handle_document_build', [l:ctx, l:server, 'header/source', l:has_extension]),
      \ })
  endfor

  echo 'Building document ...'
endfunction

let s:forwardsearch_status_success = 0
let s:forwardsearch_status_error = 1
let s:forwardsearch_status_failure = 2
let s:forwardsearch_status_unconfigured = 3

function! s:handle_document_forwardsearch(ctx, server, type, has_extension, data) abort "ctx = {counter, list, last_command_id}
  if a:ctx['last_command_id'] != lsp#_last_command()
    return
  endif

  if lsp#client#is_error(a:data['response']) || !has_key(a:data['response'], 'result')
    call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': ' . lsp#client#error_message(a:data['response']))
    return
  elseif type(a:data['response']['result']) !=# v:t_dict || !has_key(a:data['response']['result'], 'status')
    call lsp#utils#error('No searchable document found')
    return
  endif
  let l:status = a:data['response']['result']['status']
  if l:status ==# s:forwardsearch_status_success
    echomsg 'Preview success'
  elseif l:status ==# s:forwardsearch_status_error
    call lsp#utils#error('Preview failed: previewer process executed the command with errors')
  elseif l:status ==# s:forwardsearch_status_failure
    call lsp#utils#error('Preview failed: previewer process failed to start or crashed')
  elseif l:status ==# s:forwardsearch_status_unconfigured
    call lsp#utils#error('Preview failed: previewer command is not configured')
  endif
endfunction

function! s:document_forwardsearch() abort
  let l:servers = lsp#get_whitelisted_servers()

  let l:has_extension = 0
  for l:server in l:servers
    if stridx(l:server, 'texlab') != -1
      let l:has_extension += 1
    endif
  endfor

  if l:has_extension == 0
    call lsp#utils#error('Searching document not supported for '.&filetype)
    return
  endif

  let l:command_id = lsp#_new_command()
  let l:ctx = { 'counter': l:has_extension, 'list':[], 'last_command_id': l:command_id }
  for l:server in l:servers
    if stridx(l:server, 'texlab') == -1
      continue
    endif

    call lsp#send_request(l:server, {
      \ 'method': 'textDocument/forwardSearch',
      \ 'params': {
      \   'textDocument': lsp#get_text_document_identifier(),
      \   'position': lsp#get_position()
      \ },
      \ 'on_notification': function('s:handle_document_forwardsearch', [l:ctx, l:server, 'header/source', l:has_extension]),
      \ })
  endfor

  echo 'Forward search...'
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer LspDocumentBuild call <SID>document_build()
  nnoremap <buffer> <plug>(lsp-document-build) :<c-u>call <SID>document_build()<cr>
  command! -buffer LspDocumentForwardSearch call <SID>document_forwardsearch()
  nnoremap <buffer> <plug>(lsp-document-forwardsearch) :<c-u>call <SID>document_forwardsearch()<cr>
endfunction

augroup lsp_install_texlab
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
