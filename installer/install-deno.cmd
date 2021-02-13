@echo off

setlocal
curl -L -o deno-x86_64-pc-windows-msvc.zip "https://github.com/hashicorp/terraform-ls/releases/latest/download/deno-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" deno-x86_64-pc-windows-msvc.zip
del deno-x86_64-pc-windows-msvc.zip
