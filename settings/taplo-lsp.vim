" For details, see taplo documentation( https://taplo.tamasfe.dev/configuration/#configuration-file ).
let g:vim_lsp_settings_taplo_lsp_options = {
\   'activationStatus': v:true,
\   'taploConfig': 'taplo://taplo.toml',
\   'taploConfigEnabled': v:true,
\   'semanticTokens': v:false,
\   'schema': {
\     'enabled': v:true,
\     'links': v:false,
\     'repositoryEnabled': v:true,
\     'repositoryUrl': 'https://taplo.tamasfe.dev/schema_index.json',
\     'associations': {
\       '^(.*(/|\\)Cargo\.toml|Cargo\.toml)$': 'taplo://Cargo.toml',
\     },
\   },
\   'formatter': {
\      'alignEntries': v:false,
\      'alignComments': v:true,
\      'arrayTrailingComma': v:true,
\      'arrayAutoExpand': v:true,
\      'arrayAutoCollapse': v:true,
\      'compactArrays': v:true,
\      'compactInlineTables': v:false,
\      'compactEntries': v:false,
\      'columnWidth': 80,
\      'indentTables': v:false,
\      'indentEntries': v:false,
\      'indentString': v:null,
\      'reorderKeys': v:true,
\      'allowedBlankLines': 2,
\      'trailingNewline': v:true,
\      'crlf': v:false,
\   },
\   'actions':{
\     'ignoreDepracatedAssociations': v:false
\   },
\   'debug': v:false
\ }

augroup vim_lsp_settings_taplo_lsp
  au!
  LspRegisterServer {
      \ 'name': 'taplo-lsp',
      \ 'cmd': {server_info->lsp_settings#get('taplo-lsp', 'cmd', [lsp_settings#exec_path('taplo-lsp')]+lsp_settings#get('taplo-lsp', 'args', ['run']))},
      \ 'root_uri':{server_info->lsp_settings#get('taplo-lsp', 'root_uri', lsp_settings#root_uri('taplo-lsp'))},
      \ 'initialization_options': lsp_settings#get('taplo-lsp', 'initialization_options', g:vim_lsp_settings_taplo_lsp_options),
      \ 'allowlist': lsp_settings#get('taplo-lsp', 'allowlist', ['toml']),
      \ 'blocklist': lsp_settings#get('taplo-lsp', 'blocklist', []),
      \ 'config': lsp_settings#get('taplo-lsp', 'config', lsp_settings#server_config('taplo-lsp')),
      \ 'workspace_config': lsp_settings#get('taplo-lsp', 'workspace_config', {'evenBetterToml': g:vim_lsp_settings_taplo_lsp_options}),
      \ 'semantic_highlight': lsp_settings#get('taplo-lsp', 'semantic_highlight', {}),
      \ }
augroup END
