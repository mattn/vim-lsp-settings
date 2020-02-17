@echo off

curl -L -o ra_lsp_server-windows.exe "https://github.com/rust-analyzer/rust-analyzer/releases/download/2020-02-11/ra_lsp_server-windows.exe"

move ra_lsp_server-windows.exe ra_lsp_server.exe
