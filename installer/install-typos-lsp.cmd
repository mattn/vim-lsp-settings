@echo off

setlocal
set VERSION=v0.1.52
set FILE="typos-lsp-%VERSION%-x86_64-pc-windows-msvc.zip"
curl -L -o %FILE% "https://github.com/tekumara/typos-lsp/releases/download/%VERSION%/%FILE%"
call "%~dp0\run_unzip.cmd" %FILE%
move target\x86_64-pc-windows-msvc\release\typos-lsp.exe .
rd /Q /S target
del %FILE%

