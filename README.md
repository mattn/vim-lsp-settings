# vim-lsp-settings

Auto configurations for Language Server for [vim-lsp](https://github.com/prabirshrestha/vim-lsp)

## Introduction

Language Servers is not easily to install. Visual Studio Code provide easy way to install/update Language Server and Language Server Client. This plugin provide same feature on Vim.

## Installation instruction

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
```

You need to install both [vim-lsp](https://github.com/prabirshrestha/vim-lsp) and its accompanying plugins and vim-lsp-settings.

### Notice

If you use plugin manager that is merging  plugins (ex. dein), Please setting stop merging work(ex. dein / merged = 0) or set `g:lsp_settings_servers_dir` option to a different directory from the vim-lsp's default.

_reason_:

Servers are installed in `./servers` directory at the caching area in default.
But when rebuild the cache, any merging plugin manager erases old cached files(include `./servers` and server execute files) before install.
You can change the directory to install servers by set `g:lsp_settings_servers_dir` option in full path.

## Usage

```
:LspInstallServer
```

Currently, no way to uninstall/update server. Run this command again, newer version will be installed.

## Supported Languages

| Language   | Language Server                                        | Local Install |
|------------|--------------------------------------------------------|:-------------:|
| C/C++      | clangd                                                 | Yes           |
| C#         | omnisharp                                              | Yes           |
| Clojure    | clojure-lsp                                            | Yes           |
| TypeScript | typescript-language-server                             | Yes           |
| JavaScript | typescript-language-server                             | Yes           |
| JavaScript | javascript-typescript-stdio                            | Yes           |
| Python     | pyls                                                   | Yes           |
| Rust       | rls                                                    | No            |
| Go         | gopls                                                  | Yes           |
| Ruby       | solargraph                                             | Yes           |
| PHP        | intelephense                                           | Yes           |
| Java       | eclipse-jdt-ls                                         | Yes           |
| Lua        | emmylua-ls                                             | Yes           |
| Vim        | vim-language-server                                    | Yes           |
| Bash       | bash-language-server                                   | Yes           |
| Terraform  | terraform-lsp                                          | Yes           |
| Dockerfile | dockerfile-language-server-nodejs                      | Yes           |
| YAML       | yaml-language-server                                   | Yes           |
| XML        | lsp4xml                                                | Yes           |
| Fortran    | fortls                                                 | Yes           |
| Scala      | Metals                                                 | Yes           |
| Elm        | elm-language-server                                    | Yes           |
| JSON       | json-languageserver                                    | Yes           |
| Swift      | sourcekit-lsp                                          | No            |
| COBOL      | cobol-language-support                                 | Yes           |
| Reason     | reason-language-server                                 | Yes           |
| TeX        | texlab                                                 | Yes           |
| TeX        | digestif                                               | No            |
| Nim        | nimls                                                  | No            |
| D          | dls                                                    | No            |
| Elixir     | elixir-ls                                              | Yes           |
| Groovy     | groovy-language-server                                 | Yes           |
| Dart       | analysis-server-dart-snapshot                          | Yes           |
| Erlang     | erlang-ls                                              | Yes           |
| F#         | fsharp-language-server                                 | Yes           |
| GraphQL    | gql-language-server                                    | Yes           |
| Vue        | vue-language-server                                    | Yes           |
| SQL        | sql-language-server                                    | Yes           |
| Lisp       | cl-lsp                                                 | Yes           |

## Notes

### clangd (C/C++)

There is a Linux OS/version that does not run locally installed clangd due to zlib version mismatch. If you want to use clangd, please install clangd on your system.

### rls (Rust)

If you install rls already, you can use rls without configurations. But if you not installed rls yet, you can install it by following [this instruction](https://github.com/rust-lang/rls#setup).

### gql-language-server (GraphQL)

To use gql-language-server, `.gqlconfig` have to be located on the top of project directory. And schema must be pointed to the schema file correctly.

```json5
{
  schema: {
    files: 'path/to/schema.graphql'
  }
}
```

Finally, you have to install `@playlyfe/gql` into your project.

```
$ npm install @playlyfe/gql --save-dev
```

## Configurations

Most of configurations are not required.

If you install clangd already, you can use clangd for C/C++ without configurations. But if you install clang with named clangd-6.0, you can replace executable like below:

```vim
let g:lsp_settings = {
\  'clangd': {'cmd': ['clangd-6.0']}
\}
```

Overridable keys are:

* cmd (List ex: `['clangd-6.0', '-enable-snippets']`)
* initialization_options (Dictionary)
* whitelist (List)
* blacklist (List)
* config (Dictionary)
* workspace_config (Dictionary)

If you install ruby but not solargraph, you can install solargraph with following command.

If you have some Language Servers and want to use specified the server:

```vim
let g:lsp_settings_perl = 'slp'
```

If you want to disable Language Server:

```vim
let g:lsp_settings = {
\  'perl-languageserver': {
\    'disabled': 0,
\   }
\}
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
