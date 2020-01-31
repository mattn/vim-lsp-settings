@echo off

setlocal

set version=v0.1.12
curl -L -o svls-%version%-x86_64-win.zip "https://github.com/dalance/svls/releases/download/v0.1.12/svls-%version%-x86_64-win.zip"
call "%~dp0\run_unzip.cmd" svls-%version%-x86_64-win.zip
move target\x86_64-pc-windows-msvc\release\svls.exe .
rd /Q /S target
del svls-%version%-x86_64-win.zip
