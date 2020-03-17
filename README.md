# vim-lsp-settings

[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/reviewdog/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/linux_vim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/linux_neovim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/windows_vim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/windows_neovim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/mac_neovim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)

Auto configurations for Language Server for [vim-lsp](https://github.com/prabirshrestha/vim-lsp)

## Introduction

Language Servers is not easy to install. Visual Studio Code provide easy way to install/update Language Server and Language Server Client. This plugin provide same feature on Vim.

## Installation instruction

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
```

You need to install both [vim-lsp](https://github.com/prabirshrestha/vim-lsp) and its accompanying plugins and vim-lsp-settings.

If you want to use autocompletion plugin, you can use followings.

#### asyncomplete.vim
```viml
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
```

#### deoplete.nvim
```viml
Plug 'Shougo/deoplete.nvim'
Plug 'lighttiger2505/deoplete-vim-lsp'
```

### Notice

If you use plugin manager that is merging  plugins (ex. dein), Please setting stop merging work(ex. dein / merged = 0) or set `g:lsp_settings_servers_dir` option to a different directory from the vim-lsp's default.

_reason_:

vim-lsp-settings install Language Servers into:

#### Windows

```
%LOCALAPPDATA%\vim-lsp-settings\servers
```

#### Others

```
$HOME/.local/share/vim-lsp-settings/servers
```

If you define $XDG_DATA_HOME:

```
$XDG_DATA_HOME/vim-lsp-settings/servers
```

You can change the directory to install servers by set `g:lsp_settings_servers_dir` option in full path.

## Usage
While editing a file with a supported filetype:

```
:LspInstallServer
```

To uninstall server:

```
:LspUninstallServer server-name
```

Because no way to update server, please run `:LspInstallServer` again, newer version will be installed.

## Supported Languages

| Language         | Language Server                                        | Local Install |
|------------------|--------------------------------------------------------|:-------------:|
| C/C++            | clangd                                                 | Yes           |
| C#               | omnisharp                                              | Yes           |
| Clojure          | clojure-lsp                                            | Yes           |
| TypeScript       | typescript-language-server                             | Yes           |
| TypeScript       | eslint-language-server                                 | Yes           |
| JavaScript       | typescript-language-server                             | Yes           |
| JavaScript       | javascript-typescript-stdio                            | Yes           |
| JavaScript       | eslint-language-server                                 | Yes           |
| Python           | pyls                                                   | Yes           |
| Python           | pyls-ms (Microsoft Version)                            | Yes           |
| Rust             | rls                                                    | No            |
| Go               | gopls                                                  | Yes           |
| Go               | golangci-lint-langserver                               | Yes           |
| Ruby             | solargraph                                             | Yes           |
| PHP              | intelephense                                           | Yes           |
| Java             | eclipse-jdt-ls                                         | Yes           |
| Lua              | emmylua-ls                                             | Yes           |
| Vim              | vim-language-server                                    | Yes           |
| Bash             | bash-language-server                                   | Yes           |
| Terraform        | terraform-lsp                                          | Yes           |
| Dockerfile       | dockerfile-language-server-nodejs                      | Yes           |
| YAML             | yaml-language-server                                   | Yes           |
| XML              | lsp4xml                                                | Yes           |
| Fortran          | fortls                                                 | Yes           |
| Scala            | Metals                                                 | Yes           |
| Elm              | elm-language-server                                    | Yes           |
| JSON             | json-languageserver                                    | Yes           |
| Swift            | sourcekit-lsp                                          | No            |
| COBOL            | cobol-language-support                                 | Yes           |
| Reason           | reason-language-server                                 | Yes           |
| TeX              | texlab                                                 | Yes           |
| TeX              | digestif                                               | No            |
| Nim              | nimls                                                  | No            |
| D                | dls                                                    | No            |
| Elixir           | elixir-ls                                              | Yes           |
| Groovy           | groovy-language-server                                 | Yes           |
| Dart             | analysis-server-dart-snapshot                          | Yes           |
| Erlang           | erlang-ls                                              | Yes           |
| F#               | fsharp-language-server                                 | Yes           |
| GraphQL          | gql-language-server                                    | Yes           |
| Vue              | vue-language-server                                    | Yes           |
| SQL              | sql-language-server                                    | Yes           |
| Lisp             | cl-lsp                                                 | No            |
| Kotlin           | kotlin-language-server                                 | Yes           |
| R                | languageserver                                         | No            |
| SystemVerilog    | svls                                                   | Yes           |
| Apex/VisualForce | apex-jorje-lsp                                         | Yes           |
| *                | efm-langserver                                         | Yes           |

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

### [dart analysis server](https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server) (Dart)

If you have a separate existing installation of the dart analysis server and
want it to be used, it must either exist in your path, or you must specify its
location. See 'Configurations' below.

## Configurations

Most of configurations are not required.

If you install clangd already, you can use clangd for C/C++ without configurations. But if you install clang with named clangd-6.0, you can replace executable like below:

```vim
let g:lsp_settings = {
\  'clangd': {'cmd': ['clangd-6.0']},
\  'efm-langserver': {'disabled': v:false}
\}
```

Or put `.vim-lsp-settings/settings.json` on your project root directory.

```json
{
  "clangd": {
    "cmd": ["clangd-6.0"]
  },
  "efm-langserver": {
    "disabled": false
  }
}
```

If you already have the dart analysis server installed but it is not in your
path, you can still configure the settings to use it. Use the vimscript below
to change the command to start the server. Note the command has three parts:
the path to your 'dart' executable, the path to your 'analysis_server.dart.snapshot',
and the '--lsp' flag.

```vimscript
let g:lsp_settings = {
    \ 'analysis_server.dart.snapshot': {
    \     'cmd': [
    \         '/path/to/your/dart-sdk/bin/dart',
    \         '/path/to/your/dart-sdk/bin/bin/snapshots/analysis_server.dart.snapshot',
    \         '--lsp'
    \     ],
    \ },
\ }
```

To edit project local `settings.json`, do `:LspSettingsLocalEdit`.

Overridable keys are:

* cmd (List ex: `['clangd-6.0', '-enable-snippets']`)
* initialization_options (Dictionary)
* whitelist (List)
* blacklist (List)
* config (Dictionary)
* workspace_config (Dictionary)
* disabled (Boolean)
* root_uri (String)
* root_uri_patterns (List)
* semantic_highlight (Dictionary)

If you install ruby but not solargraph, you can install solargraph with following command.

If you have some Language Servers and want to use specified the server:

```vim
let g:lsp_settings_filetype_perl = 'slp'
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
```

When the servers are specifed in a list, these will be started at all.

If you want to disable Language Server:

```vim
let g:lsp_settings = {
\  'perl-languageserver': {
\    'disabled': 1,
\   }
\}
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
