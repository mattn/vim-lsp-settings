@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\kotlin-language-server
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/download/0.5.2/server.zip"
call %installer_dir%\run_unzip server.zip
del server.zip

echo @echo off ^

call %%~dp0\server\bin\kotlin-language-server.bat %%* ^

> kotlin-language-server.cmd

