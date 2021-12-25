augroup vim_lsp_settings_dot_language_server
  au!
  LspRegisterServer {
      \ 'name': 'dot-language-server',
      \ 'cmd': {server_info->lsp_settings#get('dot-language-server', 'cmd', [lsp_settings#exec_path('dot-language-server')]+lsp_settings#get('dot-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('dot-language-server', 'root_uri', lsp_settings#root_uri('dot-language-server'))},
      \ 'initialization_options': lsp_settings#get('dot-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('dot-language-server', 'allowlist', ['dot']),
      \ 'blocklist': lsp_settings#get('dot-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('dot-language-server', 'config', lsp_settings#server_config('dot-language-server')),
      \ 'workspace_config': lsp_settings#get('dot-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('dot-language-server', 'semantic_highlight', {}),
      \ }
augroup END
