@echo off

setlocal
set VERSION=0.3.6
curl -L -o EmmyLua-LS-all.jar "https://github.com/EmmyLua/EmmyLua-LanguageServer/releases/download/%VERSION%/EmmyLua-LS-all.jar"

echo @echo off ^

java -cp %%~dp0/EmmyLua-LS-all.jar com.tang.vscode.MainKt ^

> emmylua-ls.cmd

