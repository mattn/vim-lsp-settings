augroup vim_lsp_settings_svelte_language_server
  au!
  LspRegisterServer {
      \ 'name': 'svelte-language-server',
      \ 'cmd': {server_info->lsp_settings#get('svelte-language-server', 'cmd', [lsp_settings#exec_path('svelte-language-server'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('svelte-language-server', 'root_uri', lsp_settings#root_uri('svelte-language-server'))},
      \ 'initialization_options': lsp_settings#get('svelte-language-server', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('svelte-language-server', 'allowlist', ['svelte']),
      \ 'blocklist': lsp_settings#get('svelte-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('svelte-language-server', 'config', lsp_settings#server_config('svelte-language-server')),
      \ 'workspace_config': lsp_settings#get('svelte-language-server', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('svelte-language-server', 'semantic_highlight', {}),
      \ }
augroup END
