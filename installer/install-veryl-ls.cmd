@echo off

setlocal
set VERSION=v0.20.0
curl -L -o veryl-x86_64-windows.zip "https://github.com/veryl-lang/veryl/releases/download/%VERSION%/veryl-x86_64-windows.zip"
call "%~dp0\run_unzip.cmd" veryl-x86_64-windows.zip
del veryl.exe
del veryl-x86_64-windows.zip
