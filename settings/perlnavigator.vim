augroup vim_lsp_settings_perlnavigator
  au!
  LspRegisterServer {
      \ 'name': 'perlnavigator',
      \ 'cmd': {server_info->lsp_settings#get('perlnavigator', 'cmd', [lsp_settings#exec_path('perlnavigator')]+lsp_settings#get('perlnavigator', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('perlnavigator', 'root_uri', lsp_settings#root_uri('perlnavigator'))},
      \ 'initialization_options': lsp_settings#get('perlnavigator', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('perlnavigator', 'allowlist', ['perl']),
      \ 'blocklist': lsp_settings#get('perlnavigator', 'blocklist', []),
      \ 'config': lsp_settings#get('perlnavigator', 'config', lsp_settings#server_config('perlnavigator')),
      \ 'workspace_config': {server_info->lsp_settings#get('perlnavigator', 'workspace_config', {'perlnavigator': { 'perlPath': 'perl', 'enableWarnings': v:true, 'perltidyProfile': '', 'perlcriticProfile': '', 'perlcriticEnabled': v:true, 'severity5': 'warning', 'severity4': 'info', 'severity3': 'hint', 'severity2': 'hint', 'severity1': 'hint', 'includePaths': [], 'logging': v:false, 'trace': { 'server': 'verbose' }}})},
      \ 'semantic_highlight': lsp_settings#get('perlnavigator', 'semantic_highlight', {}),
      \ }
  autocmd User lsp_setup let g:lsp_experimental_workspace_folders = 1
augroup END
