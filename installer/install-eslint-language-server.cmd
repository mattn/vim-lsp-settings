@echo off

git clone "https://github.com/microsoft/vscode-eslint" .
git checkout release/1.9.1
call npm install
call npm run compile:server

echo @echo off ^

node %%~dp0\server\out\eslintServer.js --stdio %%* ^

> eslint-language-server.cmd

