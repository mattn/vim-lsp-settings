augroup vim_lsp_settings_gopls
  au!
  LspRegisterServer {
      \ 'name': 'gopls',
      \ 'cmd': {server_info->lsp_settings#get('gopls', 'cmd', [lsp_settings#exec_path('gopls')])},
      \ 'root_uri':{server_info->lsp_settings#get('gopls', 'root_uri', lsp_settings#root_uri('gopls'))},
      \ 'initialization_options': lsp_settings#get('gopls', 'initialization_options', {
      \     'completeUnimported': v:true,
      \     'matcher': 'fuzzy',
      \     'codelenses': {
      \         'generate': v:true,
      \         'test': v:true,
      \     },
      \ }),
      \ 'allowlist': lsp_settings#get('gopls', 'allowlist', ['go', 'gomod']),
      \ 'blocklist': lsp_settings#get('gopls', 'blocklist', []),
      \ 'config': lsp_settings#get('gopls', 'config', lsp_settings#server_config('gopls')),
      \ 'workspace_config': lsp_settings#get('gopls', 'workspace_config', {}),
      \ 'semantic_highlight': lsp_settings#get('gopls', 'semantic_highlight', {}),
      \ }
  autocmd User lsp_setup call s:register_command()
augroup END

function! s:register_command() abort
    if get(s:, 'setup') | return | endif
    let s:setup = 1
    call lsp#register_command('gopls.test', function('s:gopls_test'))
    call lsp#register_command('gopls.generate', function('s:gopls_generate'))
endfunction

function! s:gopls_test(context) abort
    let l:command = get(a:context, 'command', {})
    let l:arguments = get(l:command, 'arguments', [])
    let l:testfile = lsp#utils#uri_to_path(get(l:arguments, 0, ''))
    let l:package = fnamemodify(l:testfile, ':h')
    let l:test = get(l:arguments, 1, [])
    let l:cmd = ['go']

    if len(l:test) > 0
        let l:cmd += ['test', '-run', l:test[0], l:package]
        call lsp_settings#utils#term_start(l:cmd, {})
    else
        call lsp_settings#utils#error('Unsupported gopls.test ' . json_encode(l:command))
    endif
endfunction

function! s:gopls_generate(context) abort
    let l:command = get(a:context, 'command', {})
    let l:arguments = get(l:command, 'arguments', [])
    let l:package = l:arguments[0]
    let l:recursive = l:arguments[1]

    let l:cmd = ['go', 'generate', l:recursive ? './..' : l:package]

    call lsp_settings#utils#term_start(l:cmd, {})
endfunction
