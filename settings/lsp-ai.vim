augroup vim_lsp_settings_lsp_ai
  au!
  LspRegisterServer {
      \ 'name': 'lsp-ai',
      \ 'cmd': {server_info->lsp_settings#get('lsp-ai', 'cmd', [lsp_settings#exec_path('lsp-ai')]+lsp_settings#get('lsp-ai', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('lsp-ai', 'root_uri', lsp_settings#root_uri('lsp-ai'))},
      \ 'initialization_options': lsp_settings#get('lsp-ai', 'initialization_options', {
      \   'memory': {'file_store': {}},
      \   'models': {
      \     'model1': {
      \       'type': 'ollama',
      \       'model': 'deepseek-coder'
      \     }
      \   },
      \   'chat': [
      \     {
      \       'trigger': '!C',
      \       'action_display_name': 'Chat',
      \       'model': 'model1',
      \       'parameters': {
      \         'max_context': 4096,
      \         'max_tokens': 1024,
      \         'system': 'You are a code assistant chatbot.'
      \       }
      \     }
      \   ],
      \   'completion': {
      \     'model': 'model1',
      \     'parameters': {
      \       'max_context': 2000,
      \       'max_tokens': 32
      \     }
      \   }
      \ }),
      \ 'allowlist': lsp_settings#get('lsp-ai', 'allowlist', ['*']),
      \ 'blocklist': lsp_settings#get('lsp-ai', 'blocklist', []),
      \ 'config': lsp_settings#get('lsp-ai', 'config', lsp_settings#server_config('lsp-ai')),
      \ 'workspace_config': lsp_settings#get('lsp-ai', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('lsp-ai', 'semantic_highlight', {}),
      \ }
augroup END
