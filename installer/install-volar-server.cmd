@echo off

call "%~dp0\npm_install.cmd" vue-language-server @vue/language-server@~2.1.0
ren vue-language-server.cmd volar-server.cmd
call npm install typescript@5.5.4
