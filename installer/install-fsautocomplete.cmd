@echo off

setlocal
set VERSION=6.0.4
set HASH=3feaabc7-1786-4012-8e00-d664f00581e9/8d9b529256502637663ddd4048de04dc
curl -L -o dotnet-runtime-%VERSION%-win-x64.zip "https://download.visualstudio.microsoft.com/download/pr/%HASH%/dotnet-runtime-%VERSION%-win-x64.zip"
call "%~dp0\run_unzip.cmd" dotnet-runtime-%VERSION%-win-x64.zip

set url=https://github.com/fsharp/FsAutoComplete/releases/latest/download/fsautocomplete.netcore.zip

set zip=fsautocomplete.zip
curl -L %url% -o %zip%
call "%~dp0\run_unzip.cmd" %zip%

echo @echo off ^

%%~dp0\dotnet.exe %%~dp0\fsautocomplete.dll %%* ^

> fsautocomplete.cmd
