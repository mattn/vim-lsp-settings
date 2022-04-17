@echo off

setlocal
curl -L -o perlnavigator-win-x86_64.zip "https://github.com/bscan/PerlNavigator/releases/latest/download/perlnavigator-win-x86_64.zip"
call "%~dp0\run_unzip.cmd" perlnavigator-win-x86_64.zip
del perlnavigator-win-x86_64.zip

