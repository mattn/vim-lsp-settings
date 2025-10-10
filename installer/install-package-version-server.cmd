@echo off

setlocal
curl -L -o "package-version-server.zip" "https://github.com/zed-industries/package-version-server/releases/latest/download/package-version-server-x86_64-pc-windows-msvc.zip"
call "%~dp0\run_unzip.cmd" package-version-server.zip
del package-version-server.zip
