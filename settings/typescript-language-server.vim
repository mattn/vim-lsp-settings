function! Vim_lsp_settings_typescript_language_server_get_blocklist() abort
    if empty(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'node_modules/'))
        return ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue']
    endif
    if !empty(lsp#utils#find_nearest_parent_file(lsp#utils#get_buffer_path(), 'deno.json'))
        return lsp_settings#utils#warning('server "typescript-language-server" is disabled since "deno.json" is found', ['typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue'])
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
  \ }
endfunction

function! Vim_lsp_settings_typescript_language_server_setup_plugins() abort
  let plugins = []

  let vue_plugin = s:find_vue_plugin()
  if !empty(vue_plugin)
    call add(plugins, vue_plugin)
  endif

  return plugins
endfunction

augroup vim_lsp_settings_typescript_language_server
  au!
  LspRegisterServer {
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->lsp_settings#get('typescript-language-server', 'cmd', [lsp_settings#exec_path('typescript-language-server')]+lsp_settings#get('typescript-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('typescript-language-server', 'root_uri', lsp_settings#root_uri('typescript-language-server'))},
      \ 'initialization_options': lsp_settings#get('typescript-language-server', 'initialization_options', {
      \   'preferences': {
      \     'includeInlayParameterNameHintsWhenArgumentMatchesName': v:true,
      \     'includeInlayParameterNameHints': 'all',
      \     'includeInlayVariableTypeHints': v:true,
      \     'includeInlayPropertyDeclarationTypeHints': v:true,
      \     'includeInlayFunctionParameterTypeHints': v:true,
      \     'includeInlayEnumMemberValueHints': v:true,
      \     'includeInlayFunctionLikeReturnTypeHints': v:true
      \   },
      \   'plugins': Vim_lsp_settings_typescript_language_server_setup_plugins(),
      \ }),
      \ 'allowlist': lsp_settings#get('typescript-language-server', 'allowlist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue']),
      \ 'blocklist': lsp_settings#get('typescript-language-server', 'blocklist', Vim_lsp_settings_typescript_language_server_get_blocklist()),
      \ 'config': lsp_settings#get('typescript-language-server', 'config', lsp_settings#server_config('typescript-language-server')),
      \ 'workspace_config': lsp_settings#get('typescript-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('typescript-language-server', 'semantic_highlight', {}),
      \ }
augroup END
