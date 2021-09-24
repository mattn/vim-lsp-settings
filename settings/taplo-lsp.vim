" For details, see taplo documentation( https://taplo.tamasfe.dev/configuration/#configuration-file ).
let g:vim_lsp_settings_taplo_lsp_options = {
\   'activationStatus': v:true,
\   'taploConfig': 'taplo://taplo.toml',
\   'taploConfigEnabled': v:true,
\   'semanticTokens': v:false,
\   'schema': {
\     'enabled': v:true,
\     'links': v:false,
\     'repositoryEnabled': v:true,
\     'repositoryUrl': 'https://taplo.tamasfe.dev/schema_index.json',
\     'associations': {
\       '^(.*(/|\\)Cargo\.toml|Cargo\.toml)$': 'taplo://Cargo.toml',
\     },
\   },
\   'formatter': {
\      'alignEntries': v:false,
\      'alignComments': v:true,
\      'arrayTrailingComma': v:true,
\      'arrayAutoExpand': v:true,
\      'arrayAutoCollapse': v:true,
\      'compactArrays': v:true,
\      'compactInlineTables': v:false,
\      'compactEntries': v:false,
\      'columnWidth': 80,
\      'indentTables': v:false,
\      'indentEntries': v:false,
\      'indentString': v:null,
\      'reorderKeys': v:true,
\      'allowedBlankLines': 2,
\      'trailingNewline': v:true,
\      'crlf': v:false,
\   },
\   'actions':{
\     'ignoreDepracatedAssociations': v:false
\   },
\   'debug': v:false
\ }

augroup vim_lsp_settings_taplo_lsp
  au!
  LspRegisterServer {
      \ 'name': 'taplo-lsp',
      \ 'cmd': {server_info->lsp_settings#get('taplo-lsp', 'cmd', [lsp_settings#exec_path('taplo-lsp')]+lsp_settings#get('taplo-lsp', 'args', ['run']))},
      \ 'root_uri':{server_info->lsp_settings#get('taplo-lsp', 'root_uri', lsp_settings#root_uri('taplo-lsp'))},
      \ 'initialization_options': lsp_settings#get('taplo-lsp', 'initialization_options', g:vim_lsp_settings_taplo_lsp_options),
      \ 'allowlist': lsp_settings#get('taplo-lsp', 'allowlist', ['toml']),
      \ 'blocklist': lsp_settings#get('taplo-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('taplo-lsp', 'config', lsp_settings#server_config('taplo-lsp')),
      \ 'workspace_config': lsp_settings#get('taplo-lsp', 'workspace_config', {'evenBetterToml': g:vim_lsp_settings_taplo_lsp_options}),
      \ 'semantic_highlight': lsp_settings#get('taplo-lsp', 'semantic_highlight', {}),
      \ }
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled() 
augroup END


function! s:on_lsp_buffer_enabled() abort
  command! -buffer LspTomlToJson call <SID>taplo_toml_to_json(0, <q-mods>)
  command! -buffer LspJsonToToml call <SID>taplo_json_to_toml(0, <q-mods>)
  nnoremap <buffer> <plug>(lsp-toml-to-json) :<c-u>call <SID>toml_to_json(0)<cr>
  nnoremap <buffer> <plug>(lsp-json-to-toml) :<c-u>call <SID>json_to_toml(0)<cr>
endfunction

function! s:open_new_buffer(ctx, server, type, data) abort
  " Based on setting of deno
  let l:path = a:ctx['target_uri']
  let l:line = a:ctx['target_selection_range']['start']['line'] + 1
  let l:col = a:ctx['target_selection_range']['start']['character'] + 1
  let l:text = a:data['response']['result']['text']

  if a:ctx['in_preview'] ==# 1
      call lsp#ui#vim#output#preview(a:server, l:text, {
          \   'statusline': ' LSP Peek ' . a:type,
          \   'cursor': { 'line': l:line, 'col': l:col, 'align': g:lsp_peek_alignment },
          \   'filetype': &filetype
          \ })
      return
  endif
  let l:buffer = bufnr(l:path)
  let l:mods = has_key(a:ctx, 'mods') ? a:ctx['mods'] : ''
  if l:mods ==# '' && &modified && !&hidden && l:buffer != bufnr('%')
      let l:mods = &splitbelow ? 'rightbelow' : 'leftabove'
  endif
  if l:mods ==# ''
      if l:buffer == bufnr('%')
          let l:cmd = ''
      else
          let l:cmd = (l:buffer !=# -1 ? 'b ' . l:buffer : 'edit ' . l:path)
      endif
  else
      let l:cmd = l:mods . ' ' . (l:buffer !=# -1 ? 'sb ' . l:buffer : 'split ' . l:path)
  endif

  execute 'silent ' l:cmd

  setlocal modifiable
  call setline(1, split(l:text, "\n"))
  setlocal noswapfile buftype=nofile
  setlocal nomodified
  setlocal nomodifiable

  execute 'call cursor(' . l:line . ',' . l:col . ')'
endfunction

function! s:taplo_toml_to_json(in_preview, ...) abort
  let l:ctx = {
      \ 'mods': '',
      \ 'in_preview': a:in_preview,
      \ 'target_uri': 'taplo:/toml_to_json.json',
      \ 'target_selection_range': {
      \   'end': { 'character': 0, 'line': 0 },
      \   'start': { 'character': 0, 'line': 0 }
      \ }}

  let l:text = join(getline(0,'$'), "\n")
  if a:0
      let l:ctx['mods'] = a:1
  endif


  call lsp#send_request('taplo-lsp', {
      \ 'method': 'taplo/tomlToJson',
      \ 'params': {
      \     'text': l:text,
      \ },
      \ 'on_notification': function('s:open_new_buffer', [l:ctx, 'taplo-lsp', 'tomlToJson'])
      \ })
endfunction

function! s:taplo_json_to_toml(in_preview, ...) abort
  let l:ctx = {
      \ 'mods': '',
      \ 'in_preview': a:in_preview,
      \ 'target_uri': 'taplo:/json_to_toml.toml',
      \ 'target_selection_range': {
      \   'end': { 'character': 0, 'line': 0 },
      \   'start': { 'character': 0, 'line': 0 }
      \ }}
  let l:text = join(getline(0,'$'), "\n")
  if a:0
      let l:ctx['mods'] = a:1
  endif


  call lsp#send_request('taplo-lsp', {
      \ 'method': 'taplo/jsonToToml',
      \ 'params': {
      \     'text': l:text,
      \ },
      \ 'on_notification': function('s:open_new_buffer', [l:ctx, 'taplo-lsp', 'jsonToToml'])
      \ })
endfunction
