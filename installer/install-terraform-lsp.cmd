@echo off

setlocal
set VERSION=0.0.10
curl -L "https://github.com/juliosueiras/terraform-lsp/releases/download/v%VERSION%/terraform-lsp_%VERSION%_windows_amd64.tar.gz" | tar xz
