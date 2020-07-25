@echo off

setlocal
set VERSION=0.20.2
curl -L -o "vscode-eslint.vsix" "https://github.com/sumneko/vscode-lua/releases/download/v%VERSION%/lua-%VERSION%.vsix"

call "%~dp0\run_unzip.cmd" vscode-eslint.vsix
del vscode-eslint.vsix

echo @echo off ^

%%~dp0\extension\server\bin\Windows\lua-language-server.exe -E -e LANG=en %%~dp0\extension\server\main.lua %%* ^

> sumneko-lua-language-server.cmd
