augroup vim_lsp_settings_vlang_vls
  au!
  LspRegisterServer {
      \ 'name': 'v-analyzer',
      \ 'cmd': {server_info->lsp_settings#get('v-analyzer', 'cmd', [lsp_settings#exec_path('v-analyzer')]+lsp_settings#get('v-analyzer', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('v-analyzer', 'root_uri', lsp_settings#root_uri('v-analyzer'))},
      \ 'initialization_options': lsp_settings#get('v-analyzer', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('v-analyzer', 'allowlist', ['vlang']),
      \ 'blocklist': lsp_settings#get('v-analyzer', 'blocklist', []),
      \ 'config': lsp_settings#get('v-analyzer', 'config', lsp_settings#server_config('v-analyzer')),
      \ 'workspace_config': lsp_settings#get('v-analyzer', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('v-analyzer', 'semantic_highlight', {}),
      \ }
augroup END
