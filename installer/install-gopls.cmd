@echo off

setlocal

cd /d %~dp0

set server_dir=..\servers\gopls
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

set GOPATH=%cd%
set GOBIN=%cd%
go get -v -u golang.org/x/tools/gopls
rd /S /Q "src"
