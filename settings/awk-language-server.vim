augroup vim_lsp_settings_awk_language_server
  au!
  LspRegisterServer {
      \ 'name': 'awk-language-server',
      \ 'cmd': {server_info->lsp_settings#get('awk-language-server', 'cmd', [lsp_settings#exec_path('awk-language-server')]+lsp_settings#get('awk-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('awk-language-server', 'root_uri', lsp_settings#root_uri('awk-language-server'))},
      \ 'initialization_options': lsp_settings#get('awk-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('awk-language-server', 'allowlist', ['awk']),
      \ 'blocklist': lsp_settings#get('awk-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('awk-language-server', 'config', lsp_settings#server_config('awk-language-server')),
      \ 'workspace_config': lsp_settings#get('awk-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('awk-language-server', 'semantic_highlight', {}),
      \ }
augroup END
