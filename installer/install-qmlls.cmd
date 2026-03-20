@echo off

setlocal
set version="0.6"
curl -L -o "qmlls-windows.zip" "https://github.com/TheQtCompanyRnD/qmlls-workflow/releases/download/%version%/qmlls-windows-%version%.zip"
call "%~dp0\run_unzip.cmd" qmlls-windows.zip qmlls.exe
del qmlls-windows.zip
