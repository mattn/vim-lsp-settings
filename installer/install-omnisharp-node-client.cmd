@echo off

cd %~dp0
if exist "..\servers\omnisharp-node-client" rd /S /Q  "..\servers\omnisharp-node-client"
md "..\servers\omnisharp-node-client"
cd "..\servers\omnisharp-node-client"
git clone https://github.com/OmniSharp/omnisharp-node-client .

call npm install
call npm build

echo @echo off ^

node %%~dp0\languageserver\server.js ^

> omnisharp-node-client.cmd

