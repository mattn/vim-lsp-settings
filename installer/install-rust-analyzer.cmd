@echo off

setlocal
curl -L -o "rust-analyzer-windows.exe" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-windows.exe"

move rust-analyzer-windows.exe rust-analyzer.exe
