@echo off

setlocal

set PLATFORM=x86_64-pc-windows-msvc

rem Get latest release version
for /f "tokens=7 delims=/" %%i in ('curl -si "https://github.com/terror/just-lsp/releases/latest" ^| findstr /i "location:"') do (
    set "VERSION=%%i"
)

curl -L -o "just-lsp.zip" "https://github.com/terror/just-lsp/releases/download/%VERSION%/just-lsp-%VERSION%-%PLATFORM%.zip"
call "%~dp0\run_unzip.cmd" just-lsp.zip
del /F just-lsp.zip
del /F /Q Cargo.lock Cargo.toml LICENSE README.md 2>nul
echo just-lsp
.\just-lsp.exe --version
