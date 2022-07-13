function! Vim_lsp_settings_purescript_get_root_uri() abort
    let d = lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'spago.dhall'))
    if empty(d)
        return  lsp_settings#root_uri('purescript-language-server')
    endif
    return d
endfunction

augroup vim_lsp_settings_purescript_language_server
  au!
  LspRegisterServer {
      \ 'name': 'purescript-language-server',
      \ 'cmd': {server_info->lsp_settings#get('purescript-language-server', 'cmd', [lsp_settings#exec_path('purescript-language-server')]+lsp_settings#get('purescript-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('purescript-language-server', 'root_uri', Vim_lsp_settings_purescript_get_root_uri())},
      \ 'initialization_options': lsp_settings#get('purescript-language-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('purescript-language-server', 'allowlist', ['purescript']),
      \ 'blocklist': lsp_settings#get('purescript-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('purescript-language-server', 'config', lsp_settings#server_config('purescript-language-server')),
      \ 'workspace_config': lsp_settings#get('purescript-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('purescript-language-server', 'semantic_highlight', {}),
      \ }
augroup END
