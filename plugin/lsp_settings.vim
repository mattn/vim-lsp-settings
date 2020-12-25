if exists('g:loaded_lsp_settings') || !exists('*json_encode') || !has('lambda')
  finish
endif
let g:loaded_lsp_settings= 1

let g:lsp_settings_root_markers = get(g:, 'lsp_settings_root_markers', [
      \ '.git',
      \ '.git/',
      \ '.svn/',
      \ '.hg/',
      \ '.bzr/'
      \ ])

let g:lsp_progress = {}
let g:lsp_progress['title'] = ''
let g:lsp_progress['messages'] = ''
let g:lsp_progress['percentage'] = 100


command! -nargs=0 LspSettingsStatus call lsp_settings#profile#status()
command! -nargs=? LspSettingsLocalEdit call lsp_settings#profile#edit_local(<f-args>)
command! -nargs=0 LspSettingsGlobalEdit call lsp_settings#profile#edit_global()

call lsp_settings#init()
