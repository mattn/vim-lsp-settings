@echo off

setlocal
set VERSION=v0.5.0
curl -L -o "kakehashi-windows.zip" "https://github.com/atusy/kakehashi/releases/download/%VERSION%/kakehashi-%VERSION%-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" kakehashi-windows.zip
del kakehashi-windows.zip
