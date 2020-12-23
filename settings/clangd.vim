augroup vim_lsp_settings_clangd
  au!
  LspRegisterServer {
      \ 'name': 'clangd',
      \ 'cmd': {server_info->lsp_settings#get('clangd', 'cmd', [lsp_settings#exec_path('clangd')])},
      \ 'root_uri':{server_info->lsp_settings#get('clangd', 'root_uri', lsp_settings#root_uri('clangd'))},
      \ 'initialization_options': lsp_settings#get('clangd', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('clangd', 'allowlist', ['c', 'cpp', 'objc', 'objcpp']),
      \ 'blocklist': lsp_settings#get('clangd', 'blocklist', []),
      \ 'config': lsp_settings#get('clangd', 'config', lsp_settings#server_config('clangd')),
      \ 'workspace_config': lsp_settings#get('clangd', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('clangd', 'semantic_highlight', {}),
      \ }
augroup END

function! s:handle_document_switch_source_header(ctx, server, type, has_extension, data) abort "ctx = {counter, list, last_command_id}
  if a:ctx['last_command_id'] != lsp#_last_command()
    return
  endif

  if lsp#client#is_error(a:data['response']) || !has_key(a:data['response'], 'result')
    call lsp#utils#error('Failed to retrieve '. a:type . ' for ' . a:server . ': ' . lsp#client#error_message(a:data['response']))
    return
  elseif type(a:data['response']['result']) !=# v:t_string
    call lsp#utils#error('No switchable header file found')
    return
  endif
  let a:ctx['list'] = a:ctx['list'] + [lsp#utils#uri_to_path(a:data['response']['result'])]

  if a:ctx['counter'] == a:has_extension
    if empty(a:ctx['list'])
      call lsp#utils#error('No ' . a:type .' found')
    else
      call lsp#utils#tagstack#_update()

      let l:loc = {
          \ 'filename': a:ctx['list'][0],
          \ 'lnum': 0,
          \ 'col': 0,
          \ }

      call lsp#utils#location#_open_vim_list_item(l:loc, '')
      echo 'Retrieved ' . a:type
      redraw
    endif
  endif
endfunction

function! s:document_switch_source_header() abort
  let l:servers = lsp#get_whitelisted_servers()

  let l:has_extension = 0
  for l:server in l:servers
    if stridx(l:server, 'clangd') != -1
      let l:has_extension += 1
    endif
  endfor

  call setqflist([])

  if l:has_extension == 0
    call lsp#utils#error('Switching between source/header not supported for '.&filetype)
    return
  endif

  let l:command_id = lsp#_new_command()
  let l:ctx = { 'counter': l:has_extension, 'list':[], 'last_command_id': l:command_id }
  for l:server in l:servers
    if stridx(l:server, 'clangd') == -1
      continue
    endif

    call lsp#send_request(l:server, {
      \ 'method': 'textDocument/switchSourceHeader',
      \ 'params': {
      \   'uri': lsp#utils#get_buffer_uri(),
      \ },
      \ 'on_notification': function('s:handle_document_switch_source_header', [l:ctx, l:server, 'header/source', l:has_extension]),
      \ })
  endfor

  echo 'Switching between source/header ...'
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer LspDocumentSwitchSourceHeader call <SID>document_switch_source_header()
  nnoremap <buffer> <plug>(lsp-switch-source-header) :<c-u>call <SID>document_switch_source_header()<cr>
endfunction

augroup lsp_install_clangd
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
