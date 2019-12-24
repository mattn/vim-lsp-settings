# vim-lsp-settings

Auto configurations for Language Server for vim-lsp

## Instroduction

Language Servers is not easily to install. Visual Studio Code provide easy way to install/update Language Server and Language Server Client. This plugin provide same feature on Vim.

## Installation instruction

For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'mattn/vim-lsp-settings'
```

## Usage

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

```
:LspInstallServer
```

Currently, no way to uninstall/update server. Run this command again, newer version will be installed.

## Supported Languages

| Language   | Language Server                                             | Local Install |
|------------|-------------------------------------------------------------|:-------------:|
| C/C++      | clangd                                                      | No            |
| C#         | omnisharp                                                   | Yes           |
| Clojure    | clojure-lsp                                                 | Yes           |
| TypeScript | typescript-language-server                                  | Yes           |
| JavaScript | javascript-typescript-langserver/typescript-language-server | Yes           |
| Python     | pyls                                                        | Yes           |
| Rust       | rls                                                         | Yes           |
| Go         | gopls                                                       | Yes           |
| Ruby       | solargraph                                                  | Yes           |
| PHP        | intelephense-server                                         | Yes           |
| Java       | eclipse-jdt-ls                                              | Yes           |
| Lua        | emmylua-ls                                                  | Yes           |
| Vim        | vim-language-server                                         | Yes           |
| Bash       | bash-language-server                                        | Yes           |
| Terraform  | terraform-lsp                                               | Yes           |
| Dockerfile | dockerfile-language-server-nodejs                           | Yes           |
| YAML       | yaml-language-server                                        | Yes           |
| XML        | lsp4xml                                                     | Yes           |
| Fortran    | fortls                                                      | Yes           |
| Scala      | Metals                                                      | Yes           |

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
