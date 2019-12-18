@echo off

cd %~dp0
if exist "..\servers\docker-langserver" rd /S /Q  "..\servers\docker-langserver"
md "..\servers\docker-langserver"
cd "..\servers\docker-langserver"
git clone https://github.com/rcjsuen/dockerfile-language-server-nodejs .

call npm install
call npm run build

echo @echo off ^

node %%~dp0\bin\docker-langserver --stdio ^

> docker-langserver.cmd

