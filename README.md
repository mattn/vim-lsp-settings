# vim-lsp-settings

[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/reviewdog/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/linux_vim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/linux_neovim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/windows_vim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/windows_neovim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/mac_neovim/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)

Auto configurations for Language Servers for [vim-lsp](https://github.com/prabirshrestha/vim-lsp).

## Introduction

Language Servers are not easy to install. Visual Studio Code provides easy ways to install and update Language Servers and Language Server Client. This plugin provides the same feature for Vim.

## Installation

Using the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
```

You need to install both [vim-lsp](https://github.com/prabirshrestha/vim-lsp) and vim-lsp-settings.

If you want to use auto-completion, you can use one of the following.

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

If you use a plugin manager that merges  plugins (for example [dein](https://github.com/Shougo/dein.vim)), please turn of merging (for example with dein, merged = 0) or set `g:lsp_settings_servers_dir` option to a different directory from the vim-lsp's default.

_reason_:

vim-lsp-settings install Language Servers into:

#### Windows

```
%LOCALAPPDATA%\vim-lsp-settings\servers
```

#### MacOS/Linux

```
$HOME/.local/share/vim-lsp-settings/servers
```

If you define `$XDG_DATA_HOME`:

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

Because there is no way to update a server, please run `:LspInstallServer` again, the newer version will be installed.

## Supported Languages

| Language         | Language Server                                        | Local Install |
|------------------|--------------------------------------------------------|:-------------:|
| Apex/VisualForce | apex-jorje-lsp                                         | Yes           |
| Bash             | bash-language-server                                   | Yes           |
| C#               | omnisharp                                              | Yes           |
| C/C++            | clangd                                                 | Yes           |
| COBOL            | cobol-language-support                                 | Yes           |
| CSS              | css-languageserver                                     | Yes           |
| Clojure          | clojure-lsp                                            | Yes           |
| Clojure          | clj-kondo-lsp                                          | Yes           |
| Cmake            | cmake-language-server                                  | Yes           |
| D                | dls                                                    | No            |
| Dart             | analysis-server-dart-snapshot                          | Yes           |
| Dockerfile       | dockerfile-language-server-nodejs                      | Yes           |
| Elixir           | elixir-ls                                              | Yes           |
| Elm              | elm-language-server                                    | Yes           |
| Erlang           | erlang-ls                                              | Yes           |
| F#               | fsharp-language-server                                 | Yes           |
| Fortran          | fortls                                                 | Yes           |
| Go               | gopls                                                  | Yes           |
| Go               | golangci-lint-langserver                               | Yes           |
| GraphQL          | gql-language-server                                    | Yes           |
| Groovy           | groovy-language-server                                 | Yes           |
| Haskell          | haskell-ide-engine                                     | No            |
| HTML             | html-languageserver                                    | Yes           |
| HTML             | angular-language-server                                | Yes           |
| HTML             | tailwindcss-intellisense                               | Yes           |
| JSON             | json-languageserver                                    | Yes           |
| Java             | eclipse-jdt-ls                                         | Yes           |
| JavaScript       | typescript-language-server                             | Yes           |
| JavaScript       | javascript-typescript-stdio                            | Yes           |
| JavaScript       | eslint-language-server                                 | Yes           |
| Julia            | LanguageServer.jl                                      | No            |
| Kotlin           | kotlin-language-server                                 | Yes           |
| Lisp             | cl-lsp                                                 | No            |
| Lua              | emmylua-ls                                             | Yes           |
| Lua              | sumneko-lua-language-server                            | Yes           |
| Nim              | nimls                                                  | No            |
| PHP              | intelephense                                           | Yes           |
| Python           | pyls-all (pyls with dependencies)                      | Yes           |
| Python           | pyls (pyls without dependencies)                       | Yes           |
| Python           | pyls-ms (Microsoft Version)                            | Yes           |
| Python           | jedi-language-server                                   | Yes           |
| R                | languageserver                                         | No            |
| Reason           | reason-language-server                                 | Yes           |
| Ruby             | solargraph                                             | Yes           |
| Rust             | rls                                                    | No            |
| Rust             | rust-analyzer                                          | Yes           |
| SQL              | sql-language-server                                    | Yes           |
| SQL              | sqls                                                   | Yes           |
| Scala            | Metals                                                 | Yes           |
| Swift            | sourcekit-lsp                                          | No            |
| SystemVerilog    | svls                                                   | Yes           |
| TeX              | texlab                                                 | Yes           |
| TeX              | digestif                                               | No            |
| Terraform        | terraform-lsp                                          | Yes           |
| TypeScript       | typescript-language-server                             | Yes           |
| TypeScript       | eslint-language-server                                 | Yes           |
| Vim              | vim-language-server                                    | Yes           |
| Vue              | vue-language-server                                    | Yes           |
| XML              | lemminx                                                | Yes           |
| YAML             | yaml-language-server                                   | Yes           |
| *                | efm-langserver                                         | Yes           |

## Notes

### clangd (C/C++)

There is a Linux OS/version that does not run the locally installed clangd due to zlib version mismatch. If you want to use clangd, please install clangd on your system.

### rls (Rust)

If you installed rls already, you can use rls without configurations. But if you have not installed rls yet, you can install it by following [these instructions](https://github.com/rust-lang/rls#setup).

### gql-language-server (GraphQL)

To use gql-language-server, the `.gqlconfig` has to be located on the top of project directory. The schema must be pointed to the schema file correctly.

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

### [haskell ide engine](https://github.com/haskell/haskell-ide-engine) (Haskell)

If you installed hie with stack, you can use hie without configurations.
But if you have not installed hie yet, you can install it by following [these steps](https://github.com/haskell/haskell-ide-engine#installation).

## Configurations

Most of the configurations are not required.

If you installed clangd already, you can use clangd for C/C++ without any configuration. But if you installed clang with named clangd-6.0, you can replace executable like below:

```vim
let g:lsp_settings = {
\  'clangd': {'cmd': ['clangd-6.0']},
\  'efm-langserver': {'disabled': v:false}
\}
```

Or put `.vim-lsp-settings/settings.json` in your project root directory.

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
    \ 'analysis-server-dart-snapshot': {
    \     'cmd': [
    \         '/path/to/your/dart-sdk/bin/dart',
    \         '/path/to/your/dart-sdk/bin/bin/snapshots/analysis_server.dart.snapshot',
    \         '--lsp'
    \     ],
    \ },
\ }
```

To edit the project local `settings.json`, do `:LspSettingsLocalEdit`.

Overridable keys are:

* cmd (List ex: `['clangd-6.0', '-enable-snippets']`)
* initialization_options (Dictionary)
* allowlist (List)
* blocklist (List)
* config (Dictionary)
* workspace_config (Dictionary)
* disabled (Boolean)
* root_uri (String)
* root_uri_patterns (List)
* semantic_highlight (Dictionary)

If you installed ruby but not solargraph, you can install solargraph with the following command.

If you have some Language Servers and want to use specified the server:

```vim
let g:lsp_settings_filetype_perl = 'slp'
let g:lsp_settings_filetype_html = ['html-languageserver', 'angular-language-server']
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
```

When the servers are specified in a list, these will all be started.

If you want to configure Language Server to use flake8 rather than pycodestyle,
the following can be added to your `~/.vimrc` file.

```vim
let g:lsp_settings = {
\   'pyls': {
\     'workspace_config': {
\       'pyls': {
\         'configurationSources': ['flake8']
\       }
\     }
\   },
\}
```

If you want to disable a Language Server:

```vim
let g:lsp_settings = {
\  'perl-languageserver': {
\    'disabled': 1,
\   }
\}
```

When resolving the root directory for a language server, this plugin will look
for directories containing special root markers defined in `g:lsp_settings_root_markers`.

By default, this is set to:

```vim
let g:lsp_settings_root_markers = [
\   '.git',
\   '.git/',
\   '.svn',
\   '.hg',
\   '.bzr'
\ ]
```

If you need to specify alternative root markers:

```vim
let g:lsp_settings_root_markers = ['.projections.json', '.git', '.git/']
```

This would look for a custom `.projections.json`, a git submodule `.git` or a git root
`.git/` starting from the current directory upwards.

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
