@echo off

cd /d %~dp0
call npm_install tsserver typescript

cd /d %~dp0
call npm_install typescript-language-server typescript-language-server
