@echo off

setlocal

set ARCH=%PROCESSOR_ARCHITECTURE%

if /I "%ARCH%"=="ARM64" (
  set ZIPNAME=oxlint-aarch64-pc-windows-msvc.zip
  set EXEFILE=oxlint-aarch64-pc-windows-msvc.exe
) else (
  set ZIPNAME=oxlint-x86_64-pc-windows-msvc.zip
  set EXEFILE=oxlint-x86_64-pc-windows-msvc.exe
)

curl -L -o "%ZIPNAME%" "https://github.com/oxc-project/oxc/releases/latest/download/%ZIPNAME%"
call "%~dp0\run_unzip.cmd" "%ZIPNAME%"

move "%EXEFILE%" oxlint.exe
del "%ZIPNAME%"
