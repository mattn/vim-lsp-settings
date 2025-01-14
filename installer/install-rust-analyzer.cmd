@echo off

setlocal
curl -L -o "rust-analyzer-windows.zip" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" rust-analyzer-windows.zip
del rust-analyzer-windows.zip rust_analyzer.pdb
