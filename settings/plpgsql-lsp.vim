augroup vim_lsp_settings_plpgsql_lsp
  au!
  LspRegisterServer {
      \ 'name': 'plpgsql-lsp',
      \ 'cmd': {server_info->lsp_settings#get('plpgsql-lsp', 'cmd', [lsp_settings#exec_path('plpgsql-lsp')]+lsp_settings#get('plpgsql-lsp', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('plpgsql-lsp', 'root_uri', lsp_settings#root_uri('plpgsql-lsp'))},
      \ 'initialization_options': lsp_settings#get('plpgsql-lsp', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('plpgsql-lsp', 'allowlist', ['sql']),
      \ 'blocklist': lsp_settings#get('plpgsql-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('plpgsql-lsp', 'config', lsp_settings#server_config('plpgsql-lsp')),
      \ 'workspace_config': lsp_settings#get('plpgsql-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('plpgsql-lsp', 'semantic_highlight', {}),
      \ }
augroup END
