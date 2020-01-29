@echo off

if "x%1" equ "x" goto :EOF
if "x%2" equ "x" goto :EOF

setlocal

set GOPATH=%CD%\go

go get %2

echo @echo off ^

%%~dp0\go\bin\%1.exe %%* ^

> %1.cmd

endlocal
