function! s:get_current_ts_path() abort
  let ts_path = '/node_modules/typescript/lib/tsserverlibrary.js'

  let project_dir = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json')
  let tsserverlibrary_path = project_dir . ts_path

  let server_dir = lsp_settings#servers_dir() . '/astro-ls'
  let fallback_path = server_dir . ts_path

  let path = filereadable(tsserverlibrary_path) ? tsserverlibrary_path : fallback_path
  return {
        \   'serverPath': path,
        \   'localizedPath': v:null,
        \ }
endfunction

function! Vim_lsp_settings_astro_setup_ts_path(options) abort
  let initialization_options = deepcopy(a:options)
  let initialization_options['typescript'] = s:get_current_ts_path()
  return initialization_options
endfunction

let g:vim_lsp_settings_astro_options = {
      \   'typescript': {
      \     'serverPath': '',
      \     'localizedPath': v:null,
      \   },
      \ }

augroup vim_lsp_settings_astro_ls
  au!
  LspRegisterServer {
        \ 'name': 'astro-ls',
        \ 'cmd': {server_info->lsp_settings#get('astro-ls', 'cmd', [lsp_settings#exec_path('astro-ls')]+lsp_settings#get('astro-ls', 'args', ['--stdio']))},
        \ 'root_uri':{server_info->lsp_settings#get('astro-ls', 'root_uri', lsp_settings#root_uri('astro-ls'))},
        \ 'initialization_options': lsp_settings#get('astro-ls', 'initialization_options', Vim_lsp_settings_astro_setup_ts_path(g:vim_lsp_settings_astro_options)),
        \ 'allowlist': lsp_settings#get('astro-ls', 'allowlist', ['astro']),
        \ 'blocklist': lsp_settings#get('astro-ls', 'blocklist', []),
        \ 'config': lsp_settings#get('astro-ls', 'config', lsp_settings#server_config('astro-ls')),
        \ 'workspace_config': lsp_settings#get('astro-ls', 'workspace_config', {}),
        \ 'semantic_highlight': lsp_settings#get('astro-ls', 'semantic_highlight', {}),
        \ }
augroup END
