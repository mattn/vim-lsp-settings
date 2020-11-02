augroup vim_lsp_settings_terraform_ls
  au!
  LspRegisterServer {
      \ 'name': 'terraform-ls',
      \ 'cmd': {server_info->lsp_settings#get('terraform-ls', 'cmd', [lsp_settings#exec_path('terraform-ls'), 'serve'])},
      \ 'root_uri':{server_info->lsp_settings#get('terraform-ls', 'root_uri', lsp_settings#root_uri('terraform-ls'))},
      \ 'initialization_options': lsp_settings#get('terraform-ls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('terraform-ls', 'allowlist', ['terraform']),
      \ 'blocklist': lsp_settings#get('terraform-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('terraform-ls', 'config', lsp_settings#server_config('terraform-ls')),
      \ 'workspace_config': lsp_settings#get('terraform-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('terraform-ls', 'semantic_highlight', {}),
      \ }
augroup END
