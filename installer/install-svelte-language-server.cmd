@echo off

git clone --depth=1 https://github.com/sveltejs/language-tools .

npm install
npm run bootstrap
npm run build

echo @echo off ^

node %~dp0\packages\language-server\bin\server.js %*

> svelte-language-server.cmd

