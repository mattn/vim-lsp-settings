augroup vim_lsp_settings_taplo_lsp
  au!
  LspRegisterServer {
      \ 'name': 'taplo-lsp',
      \ 'cmd': {server_info->lsp_settings#get('taplo-lsp', 'cmd', [lsp_settings#exec_path('taplo-lsp')]+lsp_settings#get('taplo-lsp', 'args', ['run']))},
      \ 'root_uri':{server_info->lsp_settings#get('taplo-lsp', 'root_uri', lsp_settings#root_uri('taplo-lsp'))},
      \ 'initialization_options': lsp_settings#get('taplo-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('taplo-lsp', 'allowlist', ['toml']),
      \ 'blocklist': lsp_settings#get('taplo-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('taplo-lsp', 'config', lsp_settings#server_config('taplo-lsp')),
      \ 'workspace_config': lsp_settings#get('taplo-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('taplo-lsp', 'semantic_highlight', {}),
      \ }
augroup END
