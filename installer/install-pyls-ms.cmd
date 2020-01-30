@echo off

setlocal

curl -L -o dotnet-runtime-3.1.1-win-x64.zip "https://download.visualstudio.microsoft.com/download/pr/d9768135-4646-4839-9eea-b404bb940452/8275e4320514bab636b1627c62906ef9/dotnet-runtime-3.1.1-win-x64.zip"
call "%~dp0\run_unzip.cmd" dotnet-runtime-3.1.1-win-x64.zip

set version=0.5.10
set url=https://pvsc.blob.core.windows.net/python-language-server-stable/Python-Language-Server-win-x64.%version%.nupkg

set nupkg=./pyls.nupkg
curl -L %url% -o %nupkg%
call "%~dp0\run_unzip.cmd" %nupkg%

echo @echo off ^

%%~dp0\dotnet.exe %%~dp0\Microsoft.Python.LanguageServer.dll %%* ^

> pyls-ms.cmd
