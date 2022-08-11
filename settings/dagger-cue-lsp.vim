" NOTE: For compatibility, this looks up not only
" dagger lsp's user config but also
" cuelsp's one.
augroup vim_lsp_settings_dagger_cue_lsp
  au!
  LspRegisterServer {
      \ 'name': 'dagger_cue_lsp',
      \ 'cmd': {server_info->
      \     lsp_settings#get('dagger_cue_lsp', 'cmd',
      \     [lsp_settings#exec_path('dagger')]+
      \         lsp_settings#get('dagger_cue_lsp', 'args', ['cuelsp'],
      \         ))},
      \ 'root_uri': {server_info->
      \     lsp_settings#get('dagger_cue_lsp', 'root_uri',
      \     lsp_settings#root_uri('dagger_cue_lsp'))},
      \ 'allowlist':
      \     lsp_settings#get('dagger_cue_lsp', 'allowlist',
      \     ['cue']),
      \ 'blocklist':
      \     lsp_settings#get('dagger_cue_lsp', 'blocklist',
      \     []),
      \ 'config':
      \     lsp_settings#get('dagger_cue_lsp', 'config',
      \     lsp_settings#server_config('dagger_cue_lsp')),
      \ 'workspace_config':
      \     lsp_settings#get('dagger_cue_lsp', 'workspace_config',
      \     {}),
      \ 'semantic_highlight':
      \     lsp_settings#get('dagger_cue_lsp', 'semantic_highlight',
      \     {}),
      \ }
augroup END
