function! Vim_lsp_settings_vtsls_get_blocklist() abort
    if empty(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'node_modules/'))
        return ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue']
    endif
    if !empty(lsp#utils#find_nearest_parent_file(lsp#utils#get_buffer_path(), 'deno.json'))
        call timer_start(0, {->lsp_settings#utils#warning('server "vtsls" is disabled since "deno.json" is found')}, {'repeat': 0})
        return ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue']
    endif
    return []
endfunction

function! s:find_vue_plugin() abort
  let plugin_location = lsp_settings#servers_dir() .. '/volar-server/node_modules/@vue/typescript-plugin'
  if !isdirectory(plugin_location)
    return v:null
  endif

  return {
  \ 'name': '@vue/typescript-plugin',
  \ 'location': plugin_location,
  \ 'languages': ['vue'],
  \ 'configNamespace': 'typescript',
  \ }
endfunction

function! Vim_lsp_settings_vtsls_setup_plugins() abort
  let plugins = []

  let vue_plugin = s:find_vue_plugin()
  if !empty(vue_plugin)
    call add(plugins, vue_plugin)
  endif

  return plugins
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
      \   'vtsls': {
      \     'tsserver': {
      \       'globalPlugins': Vim_lsp_settings_vtsls_setup_plugins(),
      \     },
      \   },
      \ }),
      \ 'semantic_highlight': lsp_settings#get('vtsls', 'semantic_highlight', {}),
      \ }
augroup END
