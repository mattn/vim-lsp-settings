@echo off

setlocal
set VERSION=0.10.0
curl -L -o "vscode-tailwindcss.vsix" "https://github.com/tailwindlabs/tailwindcss-intellisense/releases/download/v%VERSION%/vscode-tailwindcss-%VERSION%.vsix"

call "%~dp0\run_unzip.cmd" vscode-tailwindcss.vsix
rem del vscode-tailwindcss.vsix

echo @echo off ^

node %%~dp0\extension\dist\tailwindServer.js %%* ^

> tailwindcss-intellisense.cmd
