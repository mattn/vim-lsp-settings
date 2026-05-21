@echo off

setlocal
set VERSION=v0.25.10
curl -L -o "markdown-oxide-windows.zip" "https://github.com/Feel-ix-343/markdown-oxide/releases/download/%VERSION%/markdown-oxide-%VERSION%-x86_64-pc-windows-gnu.zip"
call "%~dp0\run_unzip.cmd" markdown-oxide-windows.zip
del markdown-oxide-windows.zip
