@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\omnisharp-lsp
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o omnisharp-win-x64.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.34.9/omnisharp-win-x64.zip"
call %installer_dir%\run_unzip omnisharp-win-x64.zip
del omnisharp-win-x64.zip

echo @echo off ^

%%~dp0\omnisharp.exe %%* ^

> omnisharp-lsp.cmd

