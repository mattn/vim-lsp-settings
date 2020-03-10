@echo off

call "%~dp0\go_install.cmd" github.com/nametake/golangci-lint-langserver@latest
call "%~dp0\go_install.cmd" github.com/golangci/golangci-lint@latest
