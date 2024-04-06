augroup vim_lsp_settings_verible_verilog_ls
  au!
  LspRegisterServer {
      \ 'name': 'verible-verilog-ls',
      \ 'cmd': {server_info->lsp_settings#get('verible-verilog-ls', 'cmd', [lsp_settings#exec_path('verible-verilog-ls')]+lsp_settings#get('verible-verilog-ls', 'args', []))},
      \ 'root_uri':{server_info->lsp_settings#get('verible-verilog-ls', 'root_uri', lsp_settings#root_uri('verible-verilog-ls'))},
      \ 'initialization_options': lsp_settings#get('verible-verilog-ls', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('verible-verilog-ls', 'allowlist', ['verilog', 'systemverilog']),
      \ 'blocklist': lsp_settings#get('verible-verilog-ls', 'blocklist', []),
      \ 'config': lsp_settings#get('verible-verilog-ls', 'config', lsp_settings#server_config('verible-verilog-ls')),
      \ 'workspace_config': lsp_settings#get('verible-verilog-ls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('verible-verilog-ls', 'semantic_highlight', {}),
      \ }
augroup END
