@echo off

curl -L -o "vscode-eslint.vsix" "https://github.com/microsoft/vscode-eslint/releases/download/release%%2F2.1.0-next.1/vscode-eslint-2.1.0.vsix"
call "%~dp0\run_unzip.cmd" vscode-eslint.vsix
del vscode-eslint.vsix

echo @echo off ^

node %%~dp0\extension\server\out\eslintServer.js --stdio %%* ^

> eslint-language-server.cmd

