@echo off

setlocal
set VERSION=3.1.1
set HASH=d9768135-4646-4839-9eea-b404bb940452/8275e4320514bab636b1627c62906ef9
curl -L -o dotnet-runtime-%VERSION%-win-x64.zip "https://download.visualstudio.microsoft.com/download/pr/%HASH%/dotnet-runtime-%VERSION%-win-x64.zip"
call "%~dp0\run_unzip.cmd" dotnet-runtime-%VERSION%-win-x64.zip

set url=https://ci.appveyor.com/api/projects/fsautocomplete/fsautocomplete/artifacts/bin/pkgs/fsautocomplete.netcore.zip?branch=master

set zip=fsautocomplete.zip
curl -L %url% -o %zip%
call "%~dp0\run_unzip.cmd" %zip%

echo @echo off ^

%%~dp0\dotnet.exe %%~dp0\fsautocomplete.dll %%* ^

> fsautocomplete.cmd
