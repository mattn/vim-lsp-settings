@echo off

curl -L -o rls-windows.zip "https://github.com/jaredly/reason-language-server/releases/download/1.7.5/rls-windows.zip"
call "%~dp0\run_unzip.cmd" rls-windows.zip
del rls-windows.zip

move rls-windows\reason-language-server.exe reason-language-server.exe
rmdir rls-windows
