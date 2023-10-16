@echo off

setlocal
set VERSION=1.3.7
curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/download/%VERSION%/server.zip"
call "%~dp0\run_unzip.cmd" server.zip
del server.zip

echo @echo off ^

call %%~dp0\server\bin\kotlin-language-server.bat %%* ^

> kotlin-language-server.cmd

