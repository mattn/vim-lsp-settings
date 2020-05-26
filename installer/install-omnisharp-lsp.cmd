@echo off

curl -L -o omnisharp-win-x64.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.35.2/omnisharp-win-x64.zip"
call "%~dp0\run_unzip.cmd" omnisharp-win-x64.zip
del omnisharp-win-x64.zip

echo @echo off ^

%%~dp0\omnisharp.exe %%* ^

> omnisharp-lsp.cmd

