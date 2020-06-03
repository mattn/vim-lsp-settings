@echo off

setlocal
set VERSION=0.26.0
curl -L -o dls-v%VERSION%.windows.x86_64.zip https://github.com/d-language-server/dls/releases/download/v%VERSION%/dls-v%VERSION%.windows.x86_64.zip"
call "%~dp0\run_unzip.cmd" dls-v%VERSION%.windows.x86_64.zip
del dls-v%VERSION%.windows.x86_64.zip
