@echo off

curl -L -o ra_lsp_server-windows.exe "https://github.com/rust-analyzer/rust-analyzer/releases/download/2020-01-27/ra_lsp_server-windows.exe"

move ra_lsp_server-windows.exe ra_lsp_server.exe
