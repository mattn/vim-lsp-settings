@echo off

where unzip1 2>NUL
if %ERRORLEVEL% neq 0 (
    echo unzip command required
    exit /b 1
)

setlocal

cd /d %~dp0

set server_dir=..\servers\kotlin-language-server
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/download/0.5.2/server.zip"
unzip server.zip
del server.zip

echo @echo off ^

call %%~dp0\server\bin\kotlin-language-server.bat %%* ^

> kotlin-language-server.cmd

