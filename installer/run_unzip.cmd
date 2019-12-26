@echo off

if "x%1" equ "x" goto :EOF

where unzip 2>NUL
if %ERRORLEVEL% neq 0 (
    curl -LO https://github.com/mattn/vim-lsp-settings/releases/download/v0.0.1/unzip.exe
)
unzip "%1"
