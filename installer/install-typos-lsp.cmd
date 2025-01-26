@echo off

setlocal
for /f "usebackq" %%V in (`curl -Ls -o nul -w "%%{url_effective}" https://github.com/tekumara/typos-lsp/releases/latest`) do set VERSION=%%~nxV
set FILE="typos-lsp-%VERSION%-x86_64-pc-windows-msvc.zip"
curl -L -o %FILE% "https://github.com/tekumara/typos-lsp/releases/latest/download/%FILE%"
call "%~dp0\run_unzip.cmd" %FILE%
move target\x86_64-pc-windows-msvc\release\typos-lsp.exe .
rd /Q /S target
del %FILE%

