@echo off

if "x%1" equ "x" goto :EOF

setlocal

set GO111MODULE=on
set GOPATH=%cd%
set GOBIN=%cd%
go get -v -u %1
set GOBIN=
go clean -modcache
rd /S /Q "src" "pkg" 2> NUL
