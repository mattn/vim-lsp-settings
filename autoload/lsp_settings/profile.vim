function! lsp_settings#profile#load_local() abort
  try
    let l:root = lsp#utils#find_nearest_parent_directory('.', '.vim-lsp-settings')
    if !empty(l:root) && filereadable(l:root . '/settings.json')
      let l:settings = json_decode(join(readfile(l:root . '/settings.json'), "\n"))
      if  has_key(g:, 'lsp_settings')
        call lsp_settings#utils#merge(g:lsp_settings, l:settings)
      else
        let g:lsp_settings = l:settings
      endif
    endif
  catch
  endtry
endfunction

function! lsp_settings#profile#edit_local() abort
  let l:root = lsp_settings#root_path(['.vim-lsp-settings'])
  if !isdirectory(l:root)
    return
  endif
  let l:root .= '/.vim-lsp-settings'
  if !isdirectory(l:root)
    call mkdir(l:root)
  endif
  exe 'new' l:root . '/settings.json'
  if !filereadable(l:root . '/settings.json')
    call setline(1, ['{', "\t", '}'])
    call cursor([2, 2])
  endif
endfunction
