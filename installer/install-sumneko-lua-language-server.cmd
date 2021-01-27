@echo off

setlocal
set VERSION=1.12.1
curl -L -o "vscode-lua.vsix" "https://github.com/sumneko/vscode-lua/releases/download/v%VERSION%/lua-%VERSION%.vsix"

call "%~dp0\run_unzip.cmd" vscode-lua.vsix
del vscode-lua.vsix

echo @echo off ^

%%~dp0\extension\server\bin\Windows\lua-language-server.exe -E -e LANG=en %%~dp0\extension\server\main.lua %%* ^

> sumneko-lua-language-server.cmd
