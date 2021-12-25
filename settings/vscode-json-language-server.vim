augroup vim_lsp_settings_vscode_json_language_server
  au!
  LspRegisterServer {
      \ 'name': 'vscode-json-language-server',
      \ 'cmd': {server_info->lsp_settings#get('vscode-json-language-server', 'cmd', [lsp_settings#exec_path('vscode-json-language-server')]+lsp_settings#get('vscode-json-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('vscode-json-language-server', 'root_uri', lsp_settings#root_uri('vscode-json-language-server'))},
      \ 'initialization_options': lsp_settings#get('vscode-json-language-server', 'initialization_options', {'provideFormatter': v:true}),
      \ 'allowlist': lsp_settings#get('vscode-json-language-server', 'allowlist', ['json', 'jsonc']),
      \ 'blocklist': lsp_settings#get('vscode-json-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('vscode-json-language-server', 'config', lsp_settings#server_config('vscode-json-language-server')),
      \ 'workspace_config': lsp_settings#get('vscode-json-language-server', 'workspace_config', {name, key->{'json': {'format': {'enable': v:true}, 'schemas': lsp_settings#utils#load_schemas('vscode-json-language-server') + [{'fileMatch':['/vim-lsp-settings/settings.json', '/.vim-lsp-settings/settings.json'], 'url': 'https://mattn.github.io/vim-lsp-settings/local-schema.json'}]}}}),
      \ 'semantic_highlight': lsp_settings#get('vscode-json-language-server', 'semantic_highlight', {}),
      \ }
augroup END

function! s:set_schema(url) abort
  let l:name = fnamemodify(lsp#utils#get_buffer_uri(), ':t')
  let l:schema = [{'fileMatch':[l:name], 'url': a:url}]
  let l:config = lsp_settings#merge('vscode-json-language-server', 'workspace_config', {'json': {'format': {'enable': v:true}, 'schemas': l:schema}})
  call lsp#update_workspace_config('vscode-json-language-server', l:config)
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer -nargs=1 LspJsonSetSchema call <SID>set_schema(<q-args>)
endfunction

augroup lsp_install_json
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
