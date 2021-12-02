augroup vim_lsp_settings_yaml_language_server
  au!
  LspRegisterServer {
      \ 'name': 'yaml-language-server',
      \ 'cmd': {server_info->lsp_settings#get('yaml-language-server', 'cmd', [lsp_settings#exec_path('yaml-language-server')]+lsp_settings#get('yaml-language-server', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('yaml-language-server', 'root_uri', lsp_settings#root_uri('yaml-language-server'))},
      \ 'initialization_options': lsp_settings#get('yaml-language-server', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('yaml-language-server', 'allowlist', ['yaml']),
      \ 'blocklist': lsp_settings#get('yaml-language-server', 'blocklist', []),
      \ 'config': lsp_settings#get('yaml-language-server', 'config', lsp_settings#server_config('yaml-language-server')),
      \ 'workspace_config': lsp_settings#merge('yaml-language-server', 'workspace_config', {'yaml': {'format': {'enable': v:true}, 'schemas': lsp_settings#utils#load_schemas_map('yaml-language-server')}}),
      \ 'semantic_highlight': lsp_settings#get('yaml-language-server', 'semantic_highlight', {}),
      \ }
augroup END

function! s:set_schema(url) abort
  let l:name = fnamemodify(lsp#utils#get_buffer_uri(), ':t')
  let l:schema = {a:url : l:name}
  let l:config = lsp_settings#merge('yaml-language-server', 'workspace_config', {'yaml': {'format': {'enable': v:true}, 'schemas': l:schema}})
  call lsp#update_workspace_config('yaml-language-server', l:config)
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer -nargs=1 LspYamlSetSchema call <SID>set_schema(<q-args>)
endfunction

augroup lsp_install_yaml
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
