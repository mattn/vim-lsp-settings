augroup vimlsp_settings_sourcekit_lsp
  au!
  LspRegisterServer {
      \ 'name': 'sourcekit-lsp',
      \ 'cmd': {server_info->lsp_settings#get('sourcekit-lsp', 'cmd', [lsp_settings#exec_path('sourcekit-lsp')])},
      \ 'initialization_options': lsp_settings#get('sourcekit-lsp', 'initialization_options', {}),
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.git/', 'Package.swift', '.xcodeproj', '.xcworkspace', 'Cartfile', 'Podfile']))},
      \ 'whitelist': lsp_settings#get('sourcekit-lsp', 'whitelist', ['swift']),
      \ 'blacklist': lsp_settings#get('sourcekit-lsp', 'blacklist', []),
      \ 'config': lsp_settings#get('sourcekit-lsp', 'config', {}),
      \ 'workspace_config': lsp_settings#get('sourcekit-lsp', 'workspace_config', {}),
      \ }
augroup END
