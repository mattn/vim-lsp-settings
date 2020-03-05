@echo off

curl -o apex-jorje-lsp.jar "https://github.com/forcedotcom/salesforcedx-vscode/blob/develop/packages/salesforcedx-vscode-apex/out/apex-jorje-lsp.jar?raw=true"

echo @echo off ^

java -jar %%~dp0\apex-jorje-lsp.jar %%* ^

> apex-jorje-lsp.cmd
