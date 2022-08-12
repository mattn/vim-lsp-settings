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

" cf. https://github.com/johnsoncodehk/volar/blob/master/packages/shared/src/types.ts
let g:vim_lsp_settings_volar_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'languageFeatures': {
\     'references': v:true,
\     'implementation': v:true,
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
\     'codeLens': { 'showReferencesNotification': v:true },
\     'semanticTokens': v:true,
\     'codeAction': v:true,
\     'inlayHints': v:true,
\     'diagnostics': v:true,
\     'schemaRequestService': { 'getDocumentContentRequest': v:true },
\   },
\   'documentFeatures': {
\     'allowedLanguageIds': [
\       'vue',
\       'javascript',
\       'typescript',
\       'javascriptreact',
\       'typescriptreact',
\       'html'
\     ],
\     'selectionRange': v:true,
\     'foldingRange': v:true,
\     'linkedEditingRange': v:true,
\     'documentSymbol': v:true,
\     'documentColor': v:false,
\     'documentFormatting': v:true,
\   }
\ }

let g:vim_lsp_settings_volar_main_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'languageFeatures': {
\     'references': v:true,
\     'implementation': v:true,
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
\     'schemaRequestService': { 'getDocumentContentRequest': v:true },
\   }
\}

let g:vim_lsp_settings_volar_second_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'languageFeatures': {
\     'documentHighlight': v:true,
\     'documentLink': v:true,
\     'codeLens': { 'showReferencesNotification': v:true },
\     'semanticTokens': v:true,
\     'inlayHints': v:true,
\     'diagnostics': v:true,
\     'schemaRequestService': { 'getDocumentContentRequest': v:true },
\   }
\}

let g:vim_lsp_settings_volar_document_options = {
\   'typescript': {
\     'serverPath': '',
\     'localizedPath': v:null,
\   },
\   'documentFeatures': {
\     'allowedLanguageIds': [
\       'vue',
\       'javascript',
\       'typescript',
\       'javascriptreact',
\       'typescriptreact',
\       'html'
\     ],
\     'selectionRange': v:true,
\     'foldingRange': v:true,
\     'linkedEditingRange': v:true,
\     'documentSymbol': v:true,
\     'documentColor': v:false,
\     'documentFormatting': v:true
\   }
\ }

augroup vim_lsp_settings_volar_server
  au!
  if get(g:, 'vim_lsp_settings_volar_experimental_multiple_servers')
    LspRegisterServer {
    \ 'name': 'volar-server-main',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_main_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
    \ }

    LspRegisterServer {
    \ 'name': 'volar-server-second',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_second_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
    \ }

    LspRegisterServer {
    \ 'name': 'volar-server-document',
    \ 'cmd': {server_info->lsp_settings#get('volar-server', 'cmd', [lsp_settings#exec_path('volar-server')]+lsp_settings#get('volar-server', 'args', ['--stdio']))},
    \ 'root_uri':{server_info->lsp_settings#get('volar-server', 'root_uri', lsp_settings#root_uri('volar-server'))},
    \ 'initialization_options': lsp_settings#get('volar-server', 'initialization_options', Vim_lsp_settings_volar_setup_ts_path(g:vim_lsp_settings_volar_document_options)),
    \ 'allowlist': lsp_settings#get('volar-server', 'allowlist', ['vue']),
    \ 'blocklist': lsp_settings#get('volar-server', 'blocklist', []),
    \ 'config': lsp_settings#get('volar-server', 'config', lsp_settings#server_config('volar-server')),
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
    \ }
  endif
augroup END
