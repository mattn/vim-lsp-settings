augroup vimlsp_settings_terraform_lsp
  au!
  LspRegisterServer {
      \ 'name': 'terraform-lsp',
      \ 'cmd': {server_info->lsp_settings#get('terraform-lsp', 'cmd', [lsp_settings#exec_path('terraform-lsp')])},
      \ 'root_uri':{server_info->lsp_settings#get('terraform-lsp', 'root_uri', lsp_settings#root_uri(g:lsp_settings_root_markers))},
      \ 'initialization_options': lsp_settings#get('terraform-lsp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('terraform-lsp', 'whitelist', ['terraform']),
      \ 'blacklist': lsp_settings#get('terraform-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('terraform-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('terraform-lsp', 'workspace_config', {}),
      \ }
augroup END
