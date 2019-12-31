@echo off

curl -L -o omnisharp-win-x64.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.34.9/omnisharp-win-x64.zip"
call "%~dp0\run_unzip" omnisharp-win-x64.zip
del omnisharp-win-x64.zip

echo @echo off ^

%%~dp0\omnisharp.exe %%* ^

> omnisharp-lsp.cmd

