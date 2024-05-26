function! Vim_lsp_settings_vtsls_get_blocklist() abort
    if empty(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'node_modules/'))
        return ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue']
    endif
    if !empty(lsp#utils#find_nearest_parent_file(lsp#utils#get_buffer_path(), 'deno.json'))
        return lsp_settings#utils#warning('server "vtsls" is disabled since "deno.json" is found', ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue'])
    endif
    return []
endfunction

augroup vim_lsp_settings_vtsls
  au!
  LspRegisterServer {
      \ 'name': 'vtsls',
      \ 'cmd': {server_info->lsp_settings#get('vtsls', 'cmd', [lsp_settings#exec_path('vtsls')]+lsp_settings#get('vtsls', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('vtsls', 'root_uri', lsp_settings#root_uri('vtsls'))},
      \ 'initialization_options': lsp_settings#get('vtsls', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('vtsls', 'allowlist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue']),
      \ 'blocklist': lsp_settings#get('vtsls', 'blocklist', Vim_lsp_settings_vtsls_get_blocklist()),
      \ 'config': lsp_settings#get('vtsls', 'config', lsp_settings#server_config('vtsls')),
      \ 'workspace_config': lsp_settings#get('vtsls', 'workspace_config', {
      \   'typescript': {
      \     'inlayHints': {
      \       'parameterNames': {
      \         'enabled': 'all',
      \       },
      \       'parameterTypes': {
      \         'enabled': v:true,
      \       },
      \       'variableTypes': {
      \         'enabled': v:true,
      \       },
      \       'propertyDeclarationTypes': {
      \         'enabled': v:true,
      \       },
      \       'functionLikeReturnTypes': {
      \         'enabled': v:true,
      \       },
      \       'enumMemberValues': {
      \         'enabled': v:true,
      \       },
      \     },
      \   },
      \   'javascript': {
      \     'inlayHints': {
      \       'parameterNames': {
      \         'enabled': 'all',
      \       },
      \       'parameterTypes': {
      \         'enabled': v:true,
      \       },
      \       'variableTypes': {
      \         'enabled': v:true,
      \       },
      \       'propertyDeclarationTypes': {
      \         'enabled': v:true,
      \       },
      \       'functionLikeReturnTypes': {
      \         'enabled': v:true,
      \       },
      \       'enumMemberValues': {
      \         'enabled': v:true,
      \       },
      \     },
      \   },
      \ }),
      \ 'semantic_highlight': lsp_settings#get('vtsls', 'semantic_highlight', {}),
      \ }
augroup END
