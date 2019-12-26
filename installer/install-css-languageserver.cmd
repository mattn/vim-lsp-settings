@echo off

cd /d %~dp0

call npm_install css-languageserver vscode-css-languageserver-bin
