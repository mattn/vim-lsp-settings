augroup vim_lsp_settings_neocmakelsp
  au!
  LspRegisterServer {
      \ 'name': 'neocmakelsp',
      \ 'cmd': {server_info->lsp_settings#get('neocmakelsp', 'cmd', [lsp_settings#exec_path('neocmakelsp')]+lsp_settings#get('neocmakelsp', 'args', ['stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('neocmakelsp', 'root_uri', lsp_settings#root_uri('neocmakelsp'))},
      \ 'initialization_options': lsp_settings#get('neocmakelsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('neocmakelsp', 'allowlist', ['cmake']),
      \ 'blocklist': lsp_settings#get('neocmakelsp', 'blocklist', []),
      \ 'config': lsp_settings#get('neocmakelsp', 'config', lsp_settings#server_config('neocmakelsp')),
      \ 'workspace_config': lsp_settings#get('neocmakelsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('neocmakelsp', 'semantic_highlight', {}),
      \ }
augroup END
