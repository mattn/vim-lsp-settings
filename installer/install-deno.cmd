@echo off

setlocal
curl -L -o deno-x86_64-pc-windows-msvc.zip "https://github.com/denoland/deno/releases/latest/download/deno-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" deno-x86_64-pc-windows-msvc.zip
del deno-x86_64-pc-windows-msvc.zip
