@echo off

call "%~dp0\npm_install.cmd" vue-language-server @vue/language-server@~2.0.0
ren vue-language-server.cmd volar-server.cmd
call npm install typescript@5.4.2
