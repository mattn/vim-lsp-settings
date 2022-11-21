@echo off

setlocal
set VERSION=3.0.0
curl -L -o "vscode-lua.vsix" "https://github.com/sumneko/vscode-lua/releases/download/v%VERSION%/vscode-lua-v%VERSION%-win32-x64.vsix"

call "%~dp0\run_unzip.cmd" vscode-lua.vsix
del vscode-lua.vsix

echo @echo off ^

%%~dp0\extension\server\bin\lua-language-server.exe %%* ^

> sumneko-lua-language-server.cmd
