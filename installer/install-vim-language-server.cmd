@echo off

cd %~dp0
if exist "..\servers\vim-language-server" rd /S /Q  "..\servers\vim-language-server"
md "..\servers\vim-language-server"
cd "..\servers\vim-language-server"
git clone https://github.com/iamcco/vim-language-server .
call yarn

echo @echo off ^

node %%~dp0\bin\index.js --stdio ^

> vim-language-server.cmd

