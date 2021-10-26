augroup vim_lsp_settings_templ
  au!
  LspRegisterServer {
      \ 'name': 'templ',
      \ 'cmd': {server_info->lsp_settings#get('templ', 'cmd', [lsp_settings#exec_path('templ')]+lsp_settings#get('templ', 'args', ['lsp']))},
      \ 'root_uri':{server_info->lsp_settings#get('templ', 'root_uri', lsp_settings#root_uri('templ'))},
      \ 'initialization_options': lsp_settings#get('templ', 'initialization_options', {
      \     'completeUnimported': v:true,
      \     'matcher': 'fuzzy',
      \     'codelenses': {
      \         'generate': v:true,
      \         'test': v:true,
      \     },
      \ }),
      \ 'allowlist': lsp_settings#get('templ', 'allowlist', ['templ']),
      \ 'blocklist': lsp_settings#get('templ', 'blocklist', []),
      \ 'config': lsp_settings#get('templ', 'config', lsp_settings#server_config('templ')),
      \ 'workspace_config': lsp_settings#get('templ', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('templ', 'semantic_highlight', {}),
      \ }
augroup END
