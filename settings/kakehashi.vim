" Build kakehashi's languages/languageServers dynamically from the language
" servers vim-lsp-settings would launch on this machine.
function! s:initialization_options() abort
  let l:language_servers = {}
  let l:bridge = {}
  let l:executable_cache = {}
  for l:ft in sort(keys(lsp_settings#settings()))
    if l:ft ==# '_' || l:ft ==# 'markdown'
      continue
    endif
    for l:name in lsp_settings#filetype_servers(l:ft, l:executable_cache)
      if l:name ==# 'kakehashi'
        continue
      endif
      if !has_key(l:language_servers, l:name)
        let l:cmd = lsp_settings#server_command(l:name)
        if empty(l:cmd)
          continue
        endif
        let l:language_servers[l:name] = {'cmd': l:cmd, 'languages': []}
      endif
      if index(l:language_servers[l:name]['languages'], l:ft) < 0
        call add(l:language_servers[l:name]['languages'], l:ft)
      endif
      let l:bridge[l:ft] = {'enabled': v:true}
      break
    endfor
  endfor
  return {
      \ 'languages': {'markdown': {'bridge': l:bridge}},
      \ 'languageServers': l:language_servers,
      \ }
endfunction

call lsp_settings#register_server({
    \ 'name': 'kakehashi',
    \ 'cmd': {server_info->lsp_settings#get('kakehashi', 'cmd', [lsp_settings#exec_path('kakehashi')]+lsp_settings#get('kakehashi', 'args', []))},
    \ 'root_uri':{server_info->lsp_settings#get('kakehashi', 'root_uri', lsp_settings#root_uri('kakehashi'))},
    \ 'initialization_options': extend(s:initialization_options(), lsp_settings#get('kakehashi', 'initialization_options', {}), 'force'),
    \ 'allowlist': lsp_settings#get('kakehashi', 'allowlist', ['*']),
    \ 'blocklist': lsp_settings#get('kakehashi', 'blocklist', []),
    \ 'config': lsp_settings#get('kakehashi', 'config', lsp_settings#server_config('kakehashi')),
    \ 'workspace_config': lsp_settings#get('kakehashi', 'workspace_config', {}),
    \ 'semantic_highlight': lsp_settings#get('kakehashi', 'semantic_highlight', {}),
    \ })
