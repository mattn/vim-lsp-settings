@echo off

setlocal
set VERSION=v0.0.10
curl -L -o "package-version-server.zip" "https://github.com/zed-industries/package-version-server/releases/download/%VERSION%/package-version-server-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" package-version-server.zip
del package-version-server.zip
