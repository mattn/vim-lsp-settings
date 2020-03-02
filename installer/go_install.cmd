@echo off

if "x%1" equ "x" goto :EOF

set GOPATH=%cd%
set GOBIN=%cd%
go get -v -u %1
rd /S /Q "src" "pkg" 2> NULL
