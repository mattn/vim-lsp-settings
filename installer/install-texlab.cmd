@echo off

setlocal
set VERSION=1.8.0
curl -L -o texlab-x86_64-windows.zip "https://github.com/latex-lsp/texlab/releases/download/v%VERSION%/texlab-x86_64-windows.zip"
call "%~dp0\run_unzip.cmd" texlab-x86_64-windows.zip
del texlab-x86_64-windows.zip
