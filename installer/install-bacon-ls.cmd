@echo off

setlocal

set PLATFORM=x86_64-pc-windows-msvc

rem Get latest release version
for /f "tokens=7 delims=/" %%i in ('curl -si "https://github.com/crisidev/bacon-ls/releases/latest" ^| findstr /i "location:"') do (
    set "VERSION=%%i"
)

rem Install bacon-ls
curl -L -o "bacon-ls.zip" "https://github.com/crisidev/bacon-ls/releases/download/%VERSION%/bacon-ls-%VERSION%-%PLATFORM%.zip"
call "%~dp0\run_unzip.cmd" bacon-ls.zip
move /Y "target\%PLATFORM%\release\bacon-ls.exe" .
del /F bacon-ls.zip
rd /S /Q target
echo bacon-ls
.\bacon-ls.exe --version

rem Install bacon
where bacon >/dev/null 2>&1
if errorlevel 1 (
    cargo install --locked bacon
)
bacon --version
