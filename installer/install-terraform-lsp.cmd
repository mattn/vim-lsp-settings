@echo off

setlocal
set VERSION=0.0.12
curl -LO "https://github.com/juliosueiras/terraform-lsp/releases/download/v%VERSION%/terraform-lsp_%VERSION%_windows_amd64.tar.gz"
tar xvf terraform-lsp_%VERSION%_windows_amd64.tar.gz
rm terraform-lsp_%VERSION%_windows_amd64.tar.gz
