@echo off

setlocal
curl -L -o "markdown-oxide-windows.zip" "https://github.com/atusy/markdown-oxide/releases/latest/download/markdown-oxide-v0.25.10-x86_64-pc-windows-gnu.zip"
call "%~dp0\run_unzip.cmd" markdown-oxide-windows.zip
del markdown-oxide-windows.zip
