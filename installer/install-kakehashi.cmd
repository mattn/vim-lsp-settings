@echo off

setlocal
curl -L -o "kakehashi-windows.zip" "https://github.com/atusy/kakehashi/releases/latest/download/kakehashi-v0.0.10-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" kakehashi-windows.zip
del kakehashi-windows.zip
