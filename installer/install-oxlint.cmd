@echo off

setlocal

set ARCH=%PROCESSOR_ARCHITECTURE%

if /I "%ARCH%"=="ARM64" (
  set ZIPNAME=oxlint-win32-arm64.zip
  set EXEFILE=oxlint-win32-arm64.exe
) else (
  set ZIPNAME=oxlint-win32-x64.zip
  set EXEFILE=oxlint-win32-x64.exe
)

curl -L -o "%ZIPNAME%" "https://github.com/oxc-project/oxc/releases/latest/download/%ZIPNAME%"
call "%~dp0\run_unzip.cmd" "%ZIPNAME%"

move "%EXEFILE%" oxlint.exe
del "%ZIPNAME%"
