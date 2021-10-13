@echo off

setlocal
curl -L -o texlab-x86_64-windows.zip "https://github.com/latex-lsp/texlab/releases/latest/download/texlab-x86_64-windows.zip"
call "%~dp0\run_unzip.cmd" texlab-x86_64-windows.zip
del texlab-x86_64-windows.zip
