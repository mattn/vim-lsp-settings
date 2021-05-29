@echo off

where gzip 2>NUL
if %ERRORLEVEL% equ 0 (
    gzip -d %*
) else (
    curl -L -o %~dp0\gzip.exe https://github.com/mattn/vim-lsp-settings/releases/download/v0.0.1/gzip.exe
    %~dp0\gzip -d %*
)
