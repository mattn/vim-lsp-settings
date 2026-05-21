@echo off

setlocal
set VERSION=v2.7.14
curl -L -o deno-x86_64-pc-windows-msvc.zip "https://github.com/denoland/deno/releases/download/%VERSION%/deno-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" deno-x86_64-pc-windows-msvc.zip
del deno-x86_64-pc-windows-msvc.zip
