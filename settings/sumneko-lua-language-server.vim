augroup vim_lsp_settings_sumneko_lua_language_server
  let g:vim_lsp_settings_sumneko_lua_language_server_workspace_config = {
        \  'Lua': {
        \    'color': {
        \      'mode': 'Semantic'
        \    },
        \    'completion': {
        \      'callSnippet': 'Disable',
        \      'enable': v:true,
        \      'keywordSnippet': 'Replace'
        \    },
        \    'develop': {
        \      'debuggerPort': 11412,
        \      'debuggerWait': v:false,
        \      'enable': v:false
        \    },
        \    'diagnostics': {
        \      'enable': v:true,
        \      'globals': '',
        \      'severity': {}
        \    },
        \    'hover': {
        \      'enable': v:true,
        \      'viewNumber': v:true,
        \      'viewString': v:true,
        \      'viewStringMax': 1000
        \    },
        \    'runtime': {
        \      'path': ['?.lua', '?/init.lua', '?/?.lua'],
        \      'version': 'Lua 5.3'
        \    },
        \    'signatureHelp': {
        \      'enable': v:true
        \    },
        \    'workspace': {
        \      'ignoreDir': [],
        \      'maxPreload': 1000,
        \      'preloadFileSize': 100,
        \      'useGitIgnore': v:true
        \    }
        \  }
        \}

  au!
  LspRegisterServer {
      \ 'name': 'sumneko-lua-language-server',
      \ 'cmd': {server_info->lsp_settings#get('sumneko-lua-language-server', 'cmd', [lsp_settings#exec_path('sumneko-lua-language-server')])},
      \ 'root_uri':{server_info->lsp_settings#get('sumneko-lua-language-server', 'root_uri', lsp_settings#root_uri('sumneko-lua-language-server'))},
      \ 'initialization_options': lsp_settings#get('sumneko-lua-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('sumneko-lua-language-server', 'allowlist', ['lua']),
      \ 'blocklist': lsp_settings#get('sumneko-lua-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('sumneko-lua-language-server', 'config', lsp_settings#server_config('sumneko-lua-language-server')),
      \ 'workspace_config': lsp_settings#get('sumneko-lua-language-server', 'workspace_config', g:vim_lsp_settings_sumneko_lua_language_server_workspace_config),
      \ 'semantic_highlight': lsp_settings#get('sumneko-lua-language-server', 'semantic_highlight', {}),
      \ }
augroup END
