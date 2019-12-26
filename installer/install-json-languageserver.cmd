@echo off

cd /d %~dp0

call npm_install json-languageserver vscode-json-languageserver-bin
