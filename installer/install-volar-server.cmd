@echo off

call "%~dp0\npm_install.cmd" volar-server @volar/server@0.29.3
call npm install typescript@4.4
