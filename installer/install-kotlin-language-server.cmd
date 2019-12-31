@echo off

curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/download/0.5.2/server.zip"
call "%~dp0\run_unzip" server.zip
del server.zip

echo @echo off ^

call %%~dp0\server\bin\kotlin-language-server.bat %%* ^

> kotlin-language-server.cmd

