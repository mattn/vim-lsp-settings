@echo off

cd %~dp0
if exist "..\servers\omnisharp-lsp" rd /S /Q  "..\servers\omnisharp-lsp"
md "..\servers\omnisharp-lsp"
cd "..\servers\omnisharp-lsp"
curl -L -o omnisharp-win-x64.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.34.9/omnisharp-win-x64.zip"
unzip omnisharp-win-x64.zip
del omnisharp-win-x64.zip

echo @echo off ^

%%~dp0\omnisharp.exe %%* ^

> omnisharp-lsp.cmd
