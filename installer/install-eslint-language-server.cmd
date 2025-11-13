@echo off

setlocal
curl --compressed -L -o "vscode-eslint.vsix" "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/dbaeumer/vsextensions/vscode-eslint/latest/vspackage"
call "%~dp0\run_unzip.cmd" vscode-eslint.vsix
del vscode-eslint.vsix

echo @echo off ^

node %%~dp0\extension\server\out\eslintServer.js %%* ^

> eslint-language-server.cmd

