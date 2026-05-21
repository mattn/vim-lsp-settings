@echo off

setlocal
set VERSION=v0.8.20
curl -L -o perlnavigator-win-x86_64.zip "https://github.com/bscan/PerlNavigator/releases/download/%VERSION%/perlnavigator-win-x86_64.zip"
call "%~dp0\run_unzip.cmd" perlnavigator-win-x86_64.zip
move perlnavigator-win-x86_64\perlnavigator.exe .
rd /Q /S perlnavigator-win-x86_64
del perlnavigator-win-x86_64.zip

