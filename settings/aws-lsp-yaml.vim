augroup vim_lsp_settings_aws_lsp_yaml
  au!
  LspRegisterServer {
      \ 'name': 'aws-lsp-yaml',
      \ 'cmd': {server_info->lsp_settings#get('aws-lsp-yaml', 'cmd', [lsp_settings#exec_path('aws-lsp-yaml')]+lsp_settings#get('aws-lsp-yaml', 'args', ['--stdio']))},
      \ 'root_uri':{server_info->lsp_settings#get('aws-lsp-yaml', 'root_uri', lsp_settings#root_uri('aws-lsp-yaml'))},
      \ 'initialization_options': lsp_settings#get('aws-lsp-yaml', 'initialization_options', v:null),
      \ 'allowlist': lsp_settings#get('aws-lsp-yaml', 'allowlist', ['yaml']),
      \ 'blocklist': lsp_settings#get('aws-lsp-yaml', 'blocklist', []),
      \ 'config': lsp_settings#get('aws-lsp-yaml', 'config', lsp_settings#server_config('aws-lsp-yaml')),
      \ 'workspace_config': lsp_settings#merge('aws-lsp-yaml', 'workspace_config', {'yaml': {'format': {'enable': v:true}, 'schemas': lsp_settings#utils#load_schemas_map('aws-lsp-yaml')}}),
      \ 'semantic_highlight': lsp_settings#get('aws-lsp-yaml', 'semantic_highlight', {}),
      \ }
augroup END

function! s:set_schema(url) abort
  let l:name = fnamemodify(lsp#utils#get_buffer_uri(), ':t')
  let l:schema = {a:url : l:name}
  let l:config = lsp_settings#merge('aws-lsp-yaml', 'workspace_config', {'yaml': {'format': {'enable': v:true}, 'schemas': l:schema}})
  call lsp#update_workspace_config('aws-lsp-yaml', l:config)
endfunction

function! s:on_lsp_buffer_enabled() abort
  command! -buffer -nargs=1 LspYamlSetSchema call <SID>set_schema(<q-args>)
  " Force formatting to be enabled
  let l:capabilities = lsp#get_server_capabilities('aws-lsp-yaml')
  if !empty(l:capabilities)
    let l:capabilities.documentFormattingProvider = v:true
  endif
endfunction

augroup lsp_install_yaml
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

