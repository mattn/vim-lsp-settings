@echo off

cd %~dp0
if exist "..\servers\emmylua-ls" rd /S /Q  "..\servers\emmylua-ls"
md "..\servers\emmylua-ls"
cd "..\servers\emmylua-ls"
curl -L -o EmmyLua-LS-all.jar "https://ci.appveyor.com/api/buildjobs/54yf9rjvj49494pd/artifacts/EmmyLua-LS%%2Fbuild%%2Flibs%%2FEmmyLua-LS-all.jar"

echo @echo off ^

java -cp %%~dp0/EmmyLua-LS-all.jar com.tang.vscode.MainKt ^

> emmylua-ls.cmd

