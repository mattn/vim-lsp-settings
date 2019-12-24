augroup vimlsp_settings_omnisharp_lsp
  au!
  autocmd User lsp_setup ++once call lsp#register_server({
      \ 'name': 'omnisharp-lsp',
      \ 'root_uri':{server_info->lsp_settings#get('omnisharp-lsp', 'root_uri', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/'])))},
      \ 'initialization_options': lsp_settings#get('omnisharp-lsp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('omnisharp-lsp', 'whitelist', ['cs']),
      \ 'blacklist': lsp_settings#get('omnisharp-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('omnisharp-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('omnisharp-lsp', 'workspace_config', {}),
      \ })
augroup END
