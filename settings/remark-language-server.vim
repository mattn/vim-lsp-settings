augroup vim_lsp_settings_remark_language_server
  au!
  LspRegisterServer {
        \ 'name': 'remark-language-server',
        \ 'cmd': {server_info->lsp_settings#get('remark-language-server', 'cmd', [lsp_settings#exec_path('remark-language-server')]+lsp_settings#get('remark-language-server', 'args', ['--stdio']))},
        \ 'root_uri':{server_info->lsp_settings#get('remark-language-server', 'root_uri', lsp_settings#root_uri('remark-language-server'))},
        \ 'initialization_options': lsp_settings#get('remark-language-server', 'initialization_options', v:null),
        \ 'allowlist': lsp_settings#get('remark-language-server', 'allowlist', []),
        \ 'blocklist': lsp_settings#get('remark-language-server', 'blocklist', []),
        \ 'config': lsp_settings#get('remark-language-server', 'config', lsp_settings#server_config('remark-language-server')),
        \ 'workspace_config': lsp_settings#get('remark-language-server', 'workspace_config', {}),
        \ 'semantic_highlight': lsp_settings#get('remark-language-server', 'semantic_highlight', {}),
        \ }
augroup END
