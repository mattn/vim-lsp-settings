@echo off

if "x%1" equ "x" goto :EOF

where unzip 2>NUL
if %ERRORLEVEL% equ 0 (
    unzip %*
) else (
    curl -L -o %~dp0\unzip.exe https://github.com/mattn/vim-lsp-settings/releases/download/v0.0.1/unzip.exe
    %~dp0\unzip %*
)
