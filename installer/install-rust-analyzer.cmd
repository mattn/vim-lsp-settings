@echo off

setlocal
set VERSION=2026-05-18
curl -L -o "rust-analyzer-windows.zip" "https://github.com/rust-analyzer/rust-analyzer/releases/download/%VERSION%/rust-analyzer-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" rust-analyzer-windows.zip
del rust-analyzer-windows.zip rust_analyzer.pdb
