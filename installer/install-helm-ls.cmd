@echo off

setlocal
set VERSION=v0.5.4
echo Downloading helm-ls...
curl -L -o helm-ls.exe  "https://github.com/mrjosh/helm-ls/releases/download/%VERSION%/helm_ls_windows_amd64.exe"
