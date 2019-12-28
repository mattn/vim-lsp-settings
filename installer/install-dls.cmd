@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\dls
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o dls-v0.26.0.windows.x86_64.zip https://github.com/d-language-server/dls/releases/download/v0.26.0/dls-v0.26.0.windows.x86_64.zip"
call %installer_dir%\run_unzip dls-v0.26.0.windows.x86_64.zip
del dls-v0.26.0.windows.x86_64.zip
