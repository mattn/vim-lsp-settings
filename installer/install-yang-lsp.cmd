@echo off

setlocal
set VERSION=0.7.6
curl -L -o yang-language-server.zip https://github.com/TypeFox/yang-lsp/releases/download/v%VERSION%/yang-language-server_%VERSION%.zip
call "%%~dp0\run_unzip.cmd" yang-language-server.zip
del yang-language-server.zip

echo @echo off^

setlocal^

%%~dp0\yang-language-server-%VERSION%\bin\yang-language-server.bat %%* ^

> yang-lsp.cmd
