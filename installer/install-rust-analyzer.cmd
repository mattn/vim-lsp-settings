@echo off

setlocal
curl -L -o "rust-analyzer-windows.gz" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-pc-windows-msvc.gz"
call "%~dp0\run_gzip.cmd" rust-analyzer-windows.gz

move rust-analyzer-windows rust-analyzer.exe
