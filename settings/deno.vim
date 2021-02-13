augroup vim_lsp_settings_deno
  au!
  LspRegisterServer {
      \ 'name': 'deno',
      \ 'cmd': {server_info->lsp_settings#get('deno', 'cmd', [lsp_settings#exec_path('deno'), 'lsp'])},
      \ 'root_uri':{server_info->lsp_settings#get('deno', 'root_uri', '')},
      \ 'initialization_options': lsp_settings#get('deno', 'initialization_options', {
      \   'enable': v:true,
      \   'lint': v:true,
      \   'unstable': v:true,
      \   'codeLens': {
      \     'references': v:true,
      \     'referencesAllFunctions': v:true,
      \   },
      \ }),
      \ 'allowlist': lsp_settings#get('deno', 'allowlist', ['typescript', 'javascript', 'typescriptreact', 'javascriptreact']),
      \ 'blocklist': lsp_settings#get('deno', 'blocklist', {c->empty(lsp_settings#root_path(['node_modules'])) ? [] : ['typescript', 'javascript', 'typescriptreact', 'javascriptreact']}),
      \ 'config': lsp_settings#get('deno', 'config', lsp_settings#server_config('deno')),
      \ 'workspace_config': lsp_settings#get('deno', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('deno', 'semantic_highlight', {}),
      \ }
augroup END

