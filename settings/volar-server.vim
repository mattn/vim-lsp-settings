function! s:get_current_ts_path() abort
  let ts_path = '/node_modules/typescript/lib/tsserverlibrary.js'

  let project_dir = lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json')
  let tsserverlibrary_path = project_dir . ts_path

  let server_dir = lsp_settings#servers_dir() . '/volar-server'
  let fallback_path = server_dir . ts_path

  let path = filereadable(tsserverlibrary_path) ? tsserverlibrary_path : fallback_path
  return {
  \   'serverPath': path,
  \   'localizedPath': v:null,
  \ }
endfunction

function! Vim_lsp_settings_volar_setup_ts_path(options) abort
  let initialization_options = deepcopy(a:options)
  let initialization_options['typescript'] = s:get_current_ts_path()
  return initialization_options
endfunction

let g:vim_lsp_settings_volar_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'languageFeatures': {
\     'references': v:true,
\     'definition': v:true,
\     'typeDefinition': v:true,
\     'callHierarchy': v:true,
\     'hover': v:true,
\     'rename': v:true,
\     'renameFileRefactoring': v:true,
\     'signatureHelp': v:true,
\     'completion': {
\       'defaultTagNameCase': 'both',
\       'defaultAttrNameCase': 'kebabCase',
\       'getDocumentNameCasesRequest': v:false,
\       'getDocumentSelectionRequest': v:false,
\     },
\     'documentHighlight': v:true,
\     'documentLink': v:true,
\     'workspaceSymbol': v:true,
\     'codeLens': v:true,
\     'semanticTokens': v:true,
\     'codeAction': v:true,
\     'diagnostics': v:true,
\     'schemaRequestService': v:true,
\   },
\   'documentFeatures': {
\     'selectionRange': v:true,
\     'foldingRange': v:true,
\     'linkedEditingRange': v:true,
\     'documentSymbol': v:true,
\     'documentColor': v:true,
\     'documentFormatting': {
\       'defaultPrintWidth': 100,
\       'getDocumentPrintWidthRequest': v:false,
\     },
\   }
\ }

let g:vim_lsp_settings_volar_api_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'languageFeatures': {
\     'references': v:true,
\     'definition': v:true,
\     'typeDefinition': v:true,
\     'callHierarchy': v:true,
\     'hover': v:true,
\     'rename': v:true,
\     'renameFileRefactoring': v:true,
\     'signatureHelp': v:true,
\     'codeAction': v:true,
\     'workspaceSymbol': v:true,
\     'completion': {
\       'defaultTagNameCase': 'both',
\       'defaultAttrNameCase': 'kebabCase',
\       'getDocumentNameCasesRequest': v:false,
\       'getDocumentSelectionRequest': v:false,
\     },
\     'schemaRequestService': v:true,
\   }
\}

let g:vim_lsp_settings_volar_doc_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'languageFeatures': {
\     'documentHighlight': v:true,
\     'documentLink': v:true,
\     'codeLens': v:true,
\     'semanticTokens': v:true,
\     'diagnostics': v:true,
\     'schemaRequestService': v:true,
\   }
\}

let g:vim_lsp_settings_volar_html_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'documentFeatures': {
\     'selectionRange': v:true,
\     'foldingRange': v:true,
\     'linkedEditingRange': v:true,
\     'documentSymbol': v:true,
\     'documentColor': v:true,
\     'documentFormatting': {
\       'defaultPrintWidth': 100,
\       'getDocumentPrintWidthRequest': v:false,
\     },
\   }
\ }

let g:vim_lsp_settings_volar_config = {
\   'volar-api': {
\     'trace': { 'server': 'off' },
\   },
\   'volar-document': {
\     'trace': { 'server': 'off' },
\   },
\   'volar-html': {
\     'trace': { 'server': 'off' },
\   },
\   'volar': {
\     'lowPowerMode': v:false,
\     'codeLens': {
\       'references': v:false,
\       'pugTools': v:false,
\       'scriptSetupTools': v:false,
\     },
\     'formatting': {
\       'printWidth': 100,
\     },
\     'icon': {
\       'splitEditors': v:false,
\       'preview': v:false,
\       'finder': v:false,
\     },
\     'autoWrapParentheses': v:true,
\     'autoCompleteRefs': v:true,
\     'takeOverMode': {
\       'enabled': v:false,
\     },
\     'completion': {
\       'preferredTagNameCase': 'auto',
\       'preferredAttrNameCase': 'auto-kebab',
\       'autoImportComponent': v:true,
\     },
\     'preview': {
\       'port': 3333,
\       'backgroundColor': 'fff',
\       'transparentGrid': v:false,
\     },
\   }
\ }

augroup vim_lsp_settings_volar_server
  au!
  if get(g:, 'vim_lsp_settings_volar_experimental_multiple_servers')
    LspRegisterServer {
    \ 'name': 'volar-server-api',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_api_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
    \ 'workspace_config': lsp_settings#get('volar-server', 'workspace_config', g:vim_lsp_settings_volar_config),
    \ }

    LspRegisterServer {
    \ 'name': 'volar-server-doc',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_doc_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
    \ 'workspace_config': lsp_settings#get('volar-server', 'workspace_config', g:vim_lsp_settings_volar_config),
    \ }

    LspRegisterServer {
    \ 'name': 'volar-server-html',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_html_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
    \ 'workspace_config': lsp_settings#get('volar-server', 'workspace_config', g:vim_lsp_settings_volar_config),
    \ }
  else
    LspRegisterServer {
    \ 'name': 'volar-server',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
    \ 'workspace_config': lsp_settings#get('volar-server', 'workspace_config', g:vim_lsp_settings_volar_config),
    \ }
  endif
augroup END
