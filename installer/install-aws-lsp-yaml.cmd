@echo off

call "%~dp0\npm_install.cmd" yaml-language-server @aws/lsp-yaml
copy yaml-language-server.cmd aws-lsp-yaml.cmd
