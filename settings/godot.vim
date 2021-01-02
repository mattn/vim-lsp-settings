augroup vim_lsp_settings_godot
  au!
  LspRegisterServer {
      \ 'name': 'godot',
      \ 'tcp': {server_info->lsp_settings#get('godot', 'tcp', '127.0.0.1:6008')},
      \ 'root_uri':{server_info->lsp_settings#get('godot', 'root_uri', lsp_settings#root_uri('godot'))},
      \ 'initialization_options': lsp_settings#get('godot', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('godot', 'allowlist', ['gdscript3', 'gdscript']),
      \ 'blocklist': lsp_settings#get('godot', 'blocklist', []),
      \ 'config': lsp_settings#get('godot', 'config', lsp_settings#server_config('godot')),
      \ 'workspace_config': lsp_settings#get('godot', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('godot', 'semantic_highlight', {}),
      \ }
augroup END
