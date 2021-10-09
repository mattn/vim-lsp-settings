@echo off

setlocal
for /f "usebackq" %%V in (`curl -Ls -o nul -w %%{url_effective} https://github.com/hashicorp/terraform-ls/releases/latest`) do set VERSION=%%~nxV
curl -L -o terraform-ls_%VERSION%.windows.x86_64.zip "https://github.com/hashicorp/terraform-ls/releases/download/%VERSION%/terraform-ls_%VERSION:~1%_windows_amd64.zip"
call "%~dp0\run_unzip.cmd" terraform-ls_%VERSION%.windows.x86_64.zip
del terraform-ls_%VERSION%.windows.x86_64.zip
