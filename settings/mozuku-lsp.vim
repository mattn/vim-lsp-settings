augroup vim_lsp_settings_mozuku_lsp
  au!
  LspRegisterServer {
      \ 'name': 'mozuku-lsp',
      \ 'cmd': {server_info->lsp_settings#get('mozuku-lsp', 'cmd', [lsp_settings#exec_path('mozuku-lsp')]+lsp_settings#get('mozuku-lsp', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('mozuku-lsp', 'root_uri', lsp_settings#root_uri('mozuku-lsp'))},
      \ 'initialization_options': lsp_settings#get('mozuku-lsp', 'initialization_options', {"analysis": {"enableCaboCha": v:true}}),
      \ 'allowlist': lsp_settings#get('mozuku-lsp', 'allowlist', ['*']),
      \ 'blocklist': lsp_settings#get('mozuku-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('mozuku-lsp', 'config', lsp_settings#server_config('mozuku-lsp')),
      \ 'workspace_config': lsp_settings#get('mozuku-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('mozuku-lsp', 'semantic_highlight', {}),
      \ }
augroup END

function! s:on_mozuku_semanticHighlight(data) abort
  let g:hoge = a:data
endfunction

function! s:on_lsp_buffer_enabled() abort
  "call lsp#callbag#pipe(
  "   \ lsp#stream(),
  "   \ lsp#callbag#filter({x-> has_key(x, 'response') && !has_key(x['response'], 'error') && get(x['response'], 'method', '') == 'mozuku/semanticHighlights'}),
  "   \ lsp#callbag#subscribe({ 'next':{x->s:on_mozuku_semanticHighlight(x)} }),
  "   \ )
endfunction

augroup lsp_install_mozuku_lspl
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

