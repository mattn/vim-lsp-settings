augroup vim_lsp_settings_pylyzer
  au!
  LspRegisterServer {
      \ 'name': 'pylyzer',
      \ 'cmd': {server_info->lsp_settings#get('pylyzer', 'cmd', [lsp_settings#exec_path('pylyzer')]+lsp_settings#get('pylyzer', 'args', ['--server']))},
      \ 'root_uri':{server_info->lsp_settings#get('pylyzer', 'root_uri', lsp_settings#root_uri('pylyzer'))},
      \ 'initialization_options': lsp_settings#get('pylyzer', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('pylyzer', 'allowlist', ['python']),
      \ 'blocklist': lsp_settings#get('pylyzer', 'blocklist', []),
      \ 'config': lsp_settings#get('pylyzer', 'config', lsp_settings#server_config('pylyzer')),
      \ 'workspace_config': lsp_settings#get('pylyzer', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('pylyzer', 'semantic_highlight', {}),
      \ }
augroup END
