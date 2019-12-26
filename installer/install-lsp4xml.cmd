@echo off

setlocal

cd /d %~dp0

set server_dir=..\servers\lsp4xml
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -LO "https://dl.bintray.com/lsp4xml/releases/org/lsp4xml/org.eclipse.lsp4xml/0.9.1/org.eclipse.lsp4xml-0.9.1-uber.jar"

echo @echo off ^

java -jar %%~dp0\org.eclipse.lsp4xml-0.9.1-uber.jar ^

> lsp4xml.cmd

