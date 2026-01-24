augroup vim_lsp_settings_markdown_oxide
  au!
  LspRegisterServer {
      \ 'name': 'markdown-oxide',
      \ 'cmd': {server_info->lsp_settings#get('markdown-oxide', 'cmd', [lsp_settings#exec_path('markdown-oxide')])},
      \ 'root_uri':{server_info->lsp_settings#get('markdown-oxide', 'root_uri', lsp_settings#root_uri('markdown-oxide'))},
      \ 'initialization_options': lsp_settings#get('markdown-oxide', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('markdown-oxide', 'allowlist', ['markdown']),
      \ 'blocklist': lsp_settings#get('markdown-oxide', 'blocklist', []),
      \ 'config': lsp_settings#get('markdown-oxide', 'config', lsp_settings#server_config('markdown-oxide')),
      \ 'workspace_config': lsp_settings#get('markdown-oxide', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('markdown-oxide', 'semantic_highlight', {}),
      \ }
augroup END
