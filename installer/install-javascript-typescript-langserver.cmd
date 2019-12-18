@echo off

cd %~dp0
if exist "..\servers\javascript-typescript-langserver" rd /S /Q  "..\servers\javascript-typescript-langserver"
md "..\servers\javascript-typescript-langserver"
cd "..\servers\javascript-typescript-langserver"
git clone https://github.com/sourcegraph/javascript-typescript-langserver .

call npm install
call npm build

echo @echo off ^

node %%~dp0\lib\language-server-stdio.js ^

> javascript-typescript-langserver.cmd

