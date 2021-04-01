@echo off

setlocal
set VERSION=0.15.0
curl -L -o terraform-ls_v%VERSION%.windows.x86_64.zip "https://github.com/hashicorp/terraform-ls/releases/download/v%VERSION%/terraform-ls_%VERSION%_windows_amd64.zip"
call "%~dp0\run_unzip.cmd" terraform-ls_v%VERSION%.windows.x86_64.zip
del terraform-ls_v%VERSION%.windows.x86_64.zip
