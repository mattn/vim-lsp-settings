augroup vim_lsp_settings_fennel_ls
  au!
  if has('win32') || has('win64')
    let Fennel_ls_cmd = {server_info->lsp_settings#get('fennel-ls', 'cmd', ['lua.exe', lsp_settings#servers_dir().'\fennel-ls\fennel-ls']+lsp_settings#get('fennel-ls', 'args', []))}
  else
    let Fennel_ls_cmd = {server_info->lsp_settings#get('fennel-ls', 'cmd', [lsp_settings#exec_path('fennel-ls')]+lsp_settings#get('fennel-ls', 'args', []))}
  endif
  LspRegisterServer {
        \ 'name': 'fennel-ls',
        \ 'cmd': Fennel_ls_cmd,
        \ 'root_uri':{server_info->lsp_settings#get('fennel-ls', 'root_uri', lsp_settings#root_uri('fennel-ls'))},
        \ 'initialization_options': lsp_settings#get('fennel-ls', 'initialization_options', v:null),
        \ 'allowlist': lsp_settings#get('fennel-ls', 'allowlist', ['fennel']),
        \ 'blocklist': lsp_settings#get('fennel-ls', 'blocklist', []),
        \ 'config': lsp_settings#get('fennel-ls', 'config', lsp_settings#server_config('fennel-ls')),
        \ 'workspace_config': lsp_settings#get('fennel-ls', 'workspace_config', {}),
        \ 'semantic_highlight': lsp_settings#get('fennel-ls', 'semantic_highlight', {}),
        \ }
augroup END
