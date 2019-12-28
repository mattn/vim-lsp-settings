@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\texlab
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o texlab-x86_64-windows.zip "https://github.com/latex-lsp/texlab/releases/download/v1.8.0/texlab-x86_64-windows.zip"
call %installer_dir%\run_unzip texlab-x86_64-windows.zip
del texlab-x86_64-windows.zip
