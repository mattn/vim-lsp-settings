@echo off

call "%~dp0\npm_install.cmd" vue-language-server @volar/vue-language-server@0.40.13
ren vue-language-server.cmd volar-server.cmd
call npm install typescript@4.8
