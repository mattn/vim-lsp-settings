augroup vim_lsp_settings_markdown-oxide
  au!
  LspRegisterServer {
      \ 'name': 'markdown-oxide',
      \ 'cmd': {server_info->lsp_settings#get('markdown-oxide', 'cmd', [lsp_settings#exec_path('markdown-oxide')]+lsp_settings#get('markdown-oxide', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('markdown-oxide', 'root_uri', lsp_settings#root_uri('markdown-oxide'))},
      \ 'initialization_options': lsp_settings#get('markdown-oxide', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('markdown-oxide', 'allowlist', ['markdown']),
      \ 'blocklist': lsp_settings#get('markdown-oxide', 'blocklist', []),
      \ 'config': lsp_settings#get('markdown-oxide', 'config', lsp_settings#server_config('markdown-oxide')),
      \ 'workspace_config': lsp_settings#get('markdown-oxide', 'workspace_config', {}),
      \ 'capabilities': lsp_settings#get('markdown-oxide', 'capabilities', {
      \   'workspace': {
      \     'didChangeWatchedFiles': {
      \       'dynamicRegistration': v:true,
      \     },
      \   },
      \   'textDocument': {
      \     'completion': {
      \       'contextSupport': v:true,
      \       'completionItem': {
      \         'snippetSupport': v:true,
      \         'documentationFormat': ['markdown', 'plaintext'],
      \         'preselectSupport': v:true,
      \         'insertReplaceSupport': v:true,
      \         'deprecatedSupport': v:true,
      \         'commitCharactersSupport': v:true,
      \       },
      \     },
      \   },
      \ }),
      \ 'semantic_highlight': lsp_settings#get('markdown-oxide', 'semantic_highlight', {}),
      \ }
augroup END
