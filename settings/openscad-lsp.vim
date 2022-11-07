augroup vim_lsp_settings_openscad_lsp
  au!
  LspRegisterServer {
      \ 'name': 'openscad-lsp',
      \ 'cmd': {server_info->lsp_settings#get('openscad-lsp', 'cmd', [lsp_settings#exec_path('openscad-lsp')]+lsp_settings#get('openscad-lsp', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('openscad-lsp', 'root_uri', lsp_settings#root_uri('openscad-lsp'))},
      \ 'initialization_options': lsp_settings#get('openscad-lsp', 'initialization_options', {
      \     'completion': {
      \         'autoimport': { 'enable': v:true },
      \     },
      \ }),
      \ 'allowlist': lsp_settings#get('openscad-lsp', 'allowlist', ['openscad']),
      \ 'blocklist': lsp_settings#get('openscad-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('openscad-lsp', 'config', lsp_settings#server_config('openscad-lsp')),
      \ 'workspace_config': lsp_settings#get('openscad-lsp', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('openscad-lsp', 'semantic_highlight', {}),
      \ }
augroup END
