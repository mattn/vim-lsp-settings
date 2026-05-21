@echo off

setlocal
set VERSION=v5.25.1
curl -L -o texlab-x86_64-windows.zip "https://github.com/latex-lsp/texlab/releases/download/%VERSION%/texlab-x86_64-windows.zip"
call "%~dp0\run_unzip.cmd" texlab-x86_64-windows.zip
del texlab-x86_64-windows.zip
