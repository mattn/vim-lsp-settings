@echo off

setlocal
set VERSION=0.6.0
set FILE="serve-d_%VERSION%-windows.zip"
curl -L -o %FILE% https://github.com/Pure-D/serve-d/releases/download/v%VERSION%/%FILE%
call "%~dp0\run_unzip.cmd" %FILE%
del %FILE%
