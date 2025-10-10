augroup vim_lsp_settings_basedpyright_langserver
  au!
  LspRegisterServer {
      \ 'name': 'basedpyright-langserver',
      \ 'cmd': {server_info->lsp_settings#get('basedpyright-langserver', 'cmd', [lsp_settings#exec_path('basedpyright-langserver')]+lsp_settings#get('basedpyright-langserver', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('basedpyright-langserver', 'root_uri', lsp_settings#root_uri('basedpyright-langserver'))},
      \ 'initialization_options': lsp_settings#get('basedpyright-langserver', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('basedpyright-langserver', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('basedpyright-langserver', 'blocklist', []),
      \ 'config': lsp_settings#get('basedpyright-langserver', 'config', lsp_settings#server_config('basedpyright-langserver')),
      \ 'workspace_config': lsp_settings#get('basedpyright-langserver', 'workspace_config', {
      \   'python': {
      \     'analysis': {
      \       'useLibraryCodeForTypes': v:true
      \     },
      \   },
      \ }),
      \ 'semantic_highlight': lsp_settings#get('basedpyright-langserver', 'semantic_highlight', {}),
      \ }
augroup END
