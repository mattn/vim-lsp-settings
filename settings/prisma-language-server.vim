augroup vim_lsp_settings_prisma_language_server
  au!
  LspRegisterServer {
      \ 'name': 'prisma-language-server',
      \ 'cmd': {server_info->lsp_settings#get('prisma-language-server', 'cmd', [lsp_settings#exec_path('prisma-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('prisma-language-server', 'root_uri', lsp_settings#root_uri('prisma-language-server'))},
      \ 'initialization_options': lsp_settings#get('prisma-language-server', 'initialization_options', {'diagnostics': 'true'}),
      \ 'allowlist': lsp_settings#get('prisma', 'allowlist', ['prisma']),
      \ 'blocklist': lsp_settings#get('prisma-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('prisma-language-server', 'config', lsp_settings#server_config('prisma-language-server')),
      \ 'workspace_config': lsp_settings#get('prisma-language-server', 'workspace_config', {
      \   'prisma': {
      \     'prismaFmtBinPath': {c->!empty(c) ? c : lsp_settings#servers_dir() . '/prisma-language-server/prisma-fmt'}(lsp_settings#exec_path('prisma-fmt')),
      \   }
      \ }),
      \ 'semantic_highlight': lsp_settings#get('prisma-language-server', 'semantic_highlight', {}),
      \ }
augroup END
