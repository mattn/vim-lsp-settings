@echo off

set GOPATH=%cd%
set GOBIN=%cd%
go get -v -u golang.org/x/tools/gopls
rd /S /Q "src"
