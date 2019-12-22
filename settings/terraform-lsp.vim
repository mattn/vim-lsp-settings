augroup vimlsp_settings_terraform_lsp
  au!
  let settings = {
      \ 'name': 'terraform-lsp',
      \ 'cmd': {server_info->lsp_settings#get('terraform-lsp', 'cmd', [lsp_settings#exec_path('terraform-lsp')])},
      \ 'whitelist': lsp_settings#get('terraform-lsp', 'whitelist', ['terraform']),
      \ 'blacklist': lsp_settings#get('terraform-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('terraform-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('terraform-lsp', 'workspace_config', {}),
      \ }
  call lsp_settings#register_server_settings(settings)
augroup END
