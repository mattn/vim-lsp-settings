@echo off

git clone --depth=1 https://github.com/sveltejs/language-tools .

cd packages\language-server
call npm install
call npm run build
cd ..\..

echo @echo off ^

node %%~dp0\packages\language-server\bin\server.js %%* ^

> svelte-language-server.cmd

