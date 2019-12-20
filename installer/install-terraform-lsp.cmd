@echo off

cd %~dp0
if exist "..\servers\terraform-lsp" rd /S /Q  "..\servers\terraform-lsp"
md "..\servers\terraform-lsp"
cd "..\servers\terraform-lsp"
curl -L "https://github.com/juliosueiras/terraform-lsp/releases/download/v0.0.9/terraform-lsp_0.0.9_windows_amd64.tar.gz" | tar xz
