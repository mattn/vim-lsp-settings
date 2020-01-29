if exists('g:loaded_lsp_settings') || !exists('*json_encode') || !has('lambda')
  finish
endif
let g:loaded_lsp_settings= 1

let g:lsp_settings_root_markers = get(g:, 'lsp_settings_root_markers', [
      \ '.git/',
      \ '.svn/',
      \ '.hg/',
      \ '.bzr/'
      \ ])

call lsp_settings#init()
