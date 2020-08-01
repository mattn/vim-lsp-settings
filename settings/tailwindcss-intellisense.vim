augroup vim_lsp_settings_tailwindcss-intellisense
  au!
  LspRegisterServer {
      \ 'name': 'tailwindcss-intellisense',
      \ 'cmd': {server_info->lsp_settings#get('tailwindcss-intellisense', 'cmd', [lsp_settings#exec_path('tailwindcss-intellisense'), '--stdio'])},
      \ 'root_uri':{server_info->lsp_settings#get('tailwindcss-intellisense', 'root_uri', lsp_settings#root_uri('tailwindcss-intellisense'))},
      \ 'initialization_options': lsp_settings#get('tailwindcss-intellisense', 'initialization_options', {}),
      \ 'allowlist': lsp_settings#get('tailwindcss-intellisense', 'allowlist', {x-> empty(lsp_settings#root_path(['tailwind.config.js'])) ? [] : ['html', 'css']}),
      \ 'blocklist': lsp_settings#get('tailwindcss-intellisense', 'blocklist', []),
      \ 'config': lsp_settings#get('tailwindcss-intellisense', 'config', lsp_settings#server_config('tailwindcss-intellisense')),
      \ 'workspace_config': lsp_settings#get('tailwindcss-intellisense', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('tailwindcss-intellisense', 'semantic_highlight', {}),
      \ }
augroup END
