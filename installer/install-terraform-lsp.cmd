@echo off

setlocal

cd /d %~dp0

set server_dir=..\servers\terraform-lsp
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L "https://github.com/juliosueiras/terraform-lsp/releases/download/v0.0.9/terraform-lsp_0.0.9_windows_amd64.tar.gz" | tar xz
