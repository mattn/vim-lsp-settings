@echo off

setlocal
set VERSION=v0.1.16
curl -L -o svls-%VERSION%-x86_64-win.zip "https://github.com/dalance/svls/releases/download/%VERSION%/svls-%VERSION%-x86_64-win.zip"
call "%~dp0\run_unzip.cmd" svls-%VERSION%-x86_64-win.zip
move target\x86_64-pc-windows-msvc\release\svls.exe .
rd /Q /S target
del svls-%VERSION%-x86_64-win.zip
