augroup vim_lsp_settings_herb-language-server
  au!
  LspRegisterServer {
      \ 'name': 'herb-language-server',
      \ 'cmd': {server_info->lsp_settings#get('herb-language-server', 'cmd', [lsp_settings#exec_path('herb-language-server')]+lsp_settings#get('herb-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('herb-language-server', 'root_uri', lsp_settings#root_uri('herb-language-server'))},
      \ 'initialization_options': lsp_settings#get('herb-language-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('herb-language-server', 'allowlist', ['eruby', 'erb']),
      \ 'blocklist': lsp_settings#get('herb-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('herb-language-server', 'config', lsp_settings#server_config('herb-language-server')),
      \ 'workspace_config': lsp_settings#get('herb-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('herb-language-server', 'semantic_highlight', {}),
      \ }
augroup END
