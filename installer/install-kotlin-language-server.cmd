@echo off

cd %~dp0
if exist "..\servers\kotlin-language-server" rd /S /Q  "..\servers\kotlin-language-server"
md "..\servers\kotlin-language-server"
cd "..\servers\kotlin-language-server"
curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/download/0.5.2/server.zip"
unzip server.zip
del server.zip

echo @echo off ^

call %%~dp0\server\bin\kotlin-language-server.bat %%* ^

> kotlin-language-server.cmd

