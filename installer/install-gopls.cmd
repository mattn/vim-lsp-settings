@echo off

setlocal

cd %~dp0
if exist "..\servers\gopls" rd /S /Q  "..\servers\gopls"
md "..\servers\gopls"
cd "..\servers\gopls"
set GOPATH=%cd%
set GOBIN=%cd%
go get -v -u golang.org/x/tools/cmd/gopls
rd /S /Q  "src"
