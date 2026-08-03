call lsp_settings#register_server({
    \ 'name': 'tsc',
    \ 'cmd': {server_info->lsp_settings#get('tsc', 'cmd', [lsp_settings#exec_path('tsc')]+lsp_settings#get('tsc', 'args', ['--lsp', '--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('tsc', 'root_uri', lsp_settings#root_uri('tsc'))},
    \ 'initialization_options': lsp_settings#get('tsc', 'initialization_options', {}),
    \ 'allowlist': lsp_settings#get('tsc', 'allowlist', ['typescript', 'typescriptreact', 'typescript.tsx']),
    \ 'blocklist': lsp_settings#get('tsc', 'blocklist', []),
    \ 'config': lsp_settings#get('tsc', 'config', {}),
    \ 'workspace_config': lsp_settings#get('tsc', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('tsc', 'semantic_highlight', {}),
    \ })

let s:vimlsp_send_response = v:null

function! s:resolve_send_response() abort
  if exists('*getscriptinfo')
    let l:matches = getscriptinfo({'name': 'vim-lsp/autoload/lsp.vim'})
    if !empty(l:matches)
      let s:vimlsp_send_response =
        \ function('<SNR>' . l:matches[0].sid . '_send_response')
    endif
    return
  endif
  let l:lines = filter(
    \ split(execute('scriptnames'), "\n"),
    \ 'v:val =~# ''vim-lsp/autoload/lsp\.vim$''')
  if !empty(l:lines)
    let s:vimlsp_send_response =
      \ function('<SNR>' . matchstr(l:lines[0], '\d\+') . '_send_response')
  endif
endfunction

function! s:on_tsc_request(data) abort
  if get(a:data, 'server', '') !=# 'tsc'
    return
  endif
  let l:request = a:data['request']
  if l:request['method'] !=# 'client/registerCapability' && l:request['method'] !=# 'client/unregisterCapability'
    return
  endif
  if s:vimlsp_send_response is v:null
    return
  endif
  call s:vimlsp_send_response('tsc', { 'id': l:request['id'], 'result': v:null })
endfunction

function! s:on_lsp_setup() abort
  call s:resolve_send_response()
  call lsp#callbag#pipe(
    \ lsp#stream(),
    \ lsp#callbag#filter({x->
    \     has_key(x, 'request') && !has_key(x, 'response') &&
    \     has_key(x['request'], 'method')
    \ }),
    \ lsp#callbag#subscribe({'next': function('s:on_tsc_request')})
    \ )
endfunction

augroup vim_lsp_settings_tsc
  au!
  autocmd User lsp_setup call s:on_lsp_setup()
augroup END
