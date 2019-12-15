augroup vimlsp_settings_intelephense_server
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'intelephense',
      \ 'cmd': lsp_settings#get('intelephense', 'cmd', {server_info->[lsp_settings#exec_path('intelephense-server'), '--stdio']}),
      \ 'whitelist': lsp_settings#get('intelephense', 'whitelist', ['php']),
      \ 'blacklist': lsp_settings#get('intelephense', 'blacklist', []),
      \ 'config': lsp_settings#get('intelephense', 'config', {}),
      \ 'workspace_config': lsp_settings#get('intelephense', 'workspace_config', {}),
      \ })
augroup END
