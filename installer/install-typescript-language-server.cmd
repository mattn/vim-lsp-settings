@echo off

cd %~dp0
if exist "..\servers\typescript-language-server" rd /S /Q  "..\servers\typescript-language-server"
md "..\servers\typescript-language-server"
cd "..\servers\typescript-language-server"
git clone https://github.com/theia-ide/typescript-language-server .

call yarn

echo @echo off ^

node %%~dp0\server\lib\cli.js --stdio ^

> typescript-language-server.cmd

