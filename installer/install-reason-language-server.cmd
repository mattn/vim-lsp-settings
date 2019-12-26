@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\reason-language-server
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o rls-windows.zip "https://github.com/jaredly/reason-language-server/releases/download/1.7.4/rls-windows.zip"
call %installer_dir%\run_unzip rls-windows.zip
del rls-windows.zip

move rls-windows\reason-language-server.exe reason-language-server.exe
rmdir rls-windows
