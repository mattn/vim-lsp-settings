@echo off

cd %~dp0
if exist "..\servers\bash-language-server" rd /S /Q  "..\servers\bash-language-server"
md "..\servers\bash-language-server"
cd "..\servers\bash-language-server"
git clone https://github.com/mads-hartmann/bash-language-server .

call yarn
call yarn run compile:server

echo @echo off ^

node %%~dp0\server\bin\main.js start ^

> bash-language-server.cmd

