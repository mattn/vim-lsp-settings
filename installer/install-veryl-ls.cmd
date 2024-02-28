@echo off

setlocal
curl -L -o veryl-x86_64-windows.zip "https://github.com/veryl-lang/veryl/releases/latest/download/veryl-x86_64-windows.zip"
call "%~dp0\run_unzip.cmd" veryl-x86_64-windows.zip
del veryl.exe
del veryl-x86_64-windows.zip
