@echo off

cd /d %~dp0

call npm_install html-languageserver vscode-json-languageserver-bin
