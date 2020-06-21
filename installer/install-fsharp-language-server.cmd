@echo off

git clone --depth=1 https://github.com/fsprojects/fsharp-language-server .
call npm install
dotnet build -c Release

echo @echo off ^

dotnet %%~dp0\src\FSharpLanguageServer\bin\Release\netcoreapp2.0\FSharpLanguageServer.dll %%* ^

> fsharp-language-server.cmd
