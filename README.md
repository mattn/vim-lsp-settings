# vim-lsp-settings

[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/reviewdog/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)
[![Actions Status](https://github.com/mattn/vim-lsp-settings/workflows/ci/badge.svg)](https://github.com/mattn/vim-lsp-settings/actions)

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


### Auto-complete

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

### LSP server download directory

This is where LSP servers are placed on your system after you download them with `:LspInstallServer`

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

## Supported Languages

| Language         | Language Server                   | Installer | Local Install |
|------------------|-----------------------------------|:---------:|:-------------:|
| Apex/VisualForce | apex-jorje-lsp                    | Yes       | Yes           |
| Bash             | bash-language-server              | Yes       | Yes           |
| C#               | omnisharp                         | Yes       | Yes           |
| C/C++            | clangd                            | Yes       | Yes           |
| COBOL            | cobol-language-support            | Yes       | Yes           |
| CSS              | css-languageserver                | Yes       | Yes           |
| CSS              | tailwindcss-intellisense          | Yes       | Yes           |
| Clojure          | clojure-lsp                       | Yes       | Yes           |
| Clojure          | clj-kondo-lsp                     | Yes       | Yes           |
| Cmake            | cmake-language-server             | Yes       | Yes           |
| D                | dls                               | Yes       | No            |
| D                | serve-d                           | Yes       | No            |
| Dart             | analysis-server-dart-snapshot     | Yes       | Yes           |
| Dockerfile       | dockerfile-language-server-nodejs | Yes       | Yes           |
| Elixir           | elixir-ls                         | Yes       | Yes           |
| Elm              | elm-language-server               | Yes       | Yes           |
| Erlang           | erlang-ls                         | Yes       | Yes           |
| F#               | fsharp-language-server            | Yes       | Yes           |
| Fortran          | fortls                            | Yes       | Yes           |
| Go               | gopls                             | Yes       | Yes           |
| Go               | golangci-lint-langserver          | Yes       | Yes           |
| GraphQL          | graphql-language-service-cli      | Yes       | Yes           |
| GraphQL          | gql-language-server               | Yes       | Yes           |
| Groovy           | groovy-language-server            | Yes       | Yes           |
| Haskell          | haskell-ide-engine                | No        | No            |
| Haskell          | haskell-language-server           | No        | No            |
| HTML             | html-languageserver               | Yes       | Yes           |
| HTML             | angular-language-server           | Yes       | Yes           |
| HTML             | tailwindcss-intellisense          | Yes       | Yes           |
| JSON             | json-languageserver               | Yes       | Yes           |
| JSON             | rome                              | Yes       | Yes           |
| Java             | eclipse-jdt-ls                    | Yes       | Yes           |
| Java             | java-language-server              | No        | Yes           |
| JavaScript       | typescript-language-server        | Yes       | Yes           |
| JavaScript       | javascript-typescript-stdio       | Yes       | Yes           |
| JavaScript       | rome                              | Yes       | Yes           |
| JavaScript       | flow                              | Yes       | Yes           |
| JavaScript       | eslint-language-server            | Yes       | Yes           |
| Julia            | LanguageServer.jl                 | Yes       | No            |
| Java             | java-language-server              | No        | No            |
| Kotlin           | kotlin-language-server            | Yes       | Yes           |
| Lisp             | cl-lsp                            | Yes       | No            |
| Lua              | emmylua-ls                        | Yes       | Yes           |
| Lua              | sumneko-lua-language-server       | Yes       | Yes           |
| Nim              | nimls                             | No        | No            |
| PHP              | intelephense                      | Yes       | Yes           |
| PHP              | psalm-language-server             | Yes       | Yes           |
| OCaml            | ocaml-lsp                         | UNIX Only | Yes           |
| Python           | pyls-all (pyls with dependencies) | Yes       | Yes           |
| Python           | pyls (pyls without dependencies)  | Yes       | Yes           |
| Python           | pyls-ms (Microsoft Version)       | Yes       | Yes           |
| Python           | jedi-language-server              | Yes       | Yes           |
| Python           | pyright-langserver                | Yes       | Yes           |
| Prisma           | prisma-language-server            | Yes       | Yes           |
| R                | languageserver                    | Yes       | No            |
| Racket           | racket-lsp                        | Yes       | No            |
| Reason           | reason-language-server            | Yes       | Yes           |
| Ruby             | solargraph                        | Yes       | Yes           |
| Rust             | rls                               | Yes       | No            |
| Rust             | rust-analyzer                     | Yes       | Yes           |
| Sphinx           | esbonio                           | Yes       | Yes           |
| SQL              | sql-language-server               | Yes       | Yes           |
| SQL              | sqls                              | Yes       | Yes           |
| Scala            | Metals                            | Yes       | Yes           |
| Svelte           | svelte-language-server            | Yes       | Yes           |
| Swift            | sourcekit-lsp                     | Yes       | No            |
| SystemVerilog    | svls                              | Yes       | Yes           |
| TeX              | texlab                            | Yes       | Yes           |
| TeX              | digestif                          | Yes       | No            |
| Terraform        | terraform-lsp                     | Yes       | Yes           |
| Terraform        | terraform-ls                      | Yes       | Yes           |
| TTCN-3           | ntt                               | Yes       | Yes           |
| TypeScript       | typescript-language-server        | Yes       | Yes           |
| TypeScript       | deno                              | Yes       | Yes           |
| TypeScript       | rome                              | Yes       | Yes           |
| TypeScript       | eslint-language-server            | Yes       | Yes           |
| Vim              | vim-language-server               | Yes       | Yes           |
| Vala             | vala-language-server              | No        | No            |
| Vue              | vue-language-server               | Yes       | Yes           |
| V                | vls                               | Yes       | Yes           |
| XML              | lemminx                           | Yes       | Yes           |
| YAML             | yaml-language-server              | Yes       | Yes           |
| ZIG              | zls                               | No        | No            |
| *                | efm-langserver                    | Yes       | Yes           |

## Notes

### clangd (C/C++)

There is a Linux OS/version that does not run the locally installed `clangd` due to zlib version mismatch. If you want to use `clangd`, please install `clangd` on your system.

### rls (Rust)

If you installed `rls` already, you can use `rls` without configurations. But if you have not installed `rls` yet, you can install it by following [these instructions](https://github.com/rust-lang/rls#setup).

### deno (TypeScript)

To use deno, `node_modules` should **not** located on the project directory or traversing the filesystem upwards.

When editing Node projects, the following warning message is shown.

`server "deno" is disabled since "node_modules" is found`

If you want to disable warning message, you may put `.vim-lsp-settings/settings.json` in your project root directory.

```json
{
  "deno": {
    "disabled": true
  }
}
```

To use importMap, default file name is `import_map.json`.

If you don't want to use `import_map.json`, you may put `.vim-lsp-settings/settings.json` in your project root directory and set importMap whatever you want.

```
{
  "deno": {
    "initialization_options": {
      "enable": true,
      "lint": true,
      "unstable": true,
      "importMap": "your_own_import_map.json"
    }
  }
}
```

### flow (JavaScript)

To use flow, the `.flowconfig` has to be located on the top of project directory.

### graphql-language-service-cli(GraphQL)

To use graphql-language-service-cli, the [GraphQL Config](https://graphql-config.com/introduction#examples) has to be located on the top of project directory. The schema must be pointed to the schema file correctly.

```json
{
  "schema": "./schema.graphql"
}
```

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

If you installed `hie` with stack, you can use hie without configurations.
But if you have not installed `hie` yet, you can install it by following [these steps](https://github.com/haskell/haskell-ide-engine#installation).

## Extra Configurations

Most of the configurations are not required.

If you installed `clangd` already, you can use `clangd` for C/C++ without any configuration. But if you installed `clang` with the name` clangd-6.0`, you can replace executable with the following config:

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

If you have some Language Servers and want to use specified the server:

```vim
let g:lsp_settings_filetype_perl = 'slp'
let g:lsp_settings_filetype_html = ['html-languageserver', 'angular-language-server']
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server']
```

When the servers are specified in a list, these will all be started.

If you want to configure Language Server to use `flake8` rather than `pycodestyle`,
the following can be added to your `~/.vimrc` file.
Note that `pyls-all` was the automatically registered server name. Check with `:LspStatus`.

```vim
let g:lsp_settings = {
\   'pyls-all': {
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
