function! lsp_settings#get(name, key, default) abort
  let l:config = get(g:, 'lsp_settings', {})
  if !has_key(l:config, a:name)
    return a:default
  endif
  let l:config = l:config[a:name]
  if !has_key(l:config, a:key)
    return a:default
  endif
  return l:config[a:key]
endfunction
