@echo off

setlocal

set ARCH=%PROCESSOR_ARCHITECTURE%

if /I "%ARCH%"=="ARM64" (
  set ZIPNAME=oxfmt-aarch64-pc-windows-msvc.zip
  set EXEFILE=oxfmt-aarch64-pc-windows-msvc.exe
) else (
  set ZIPNAME=oxfmt-x86_64-pc-windows-msvc.zip
  set EXEFILE=oxfmt-x86_64-pc-windows-msvc.exe
)

curl -L -o "%ZIPNAME%" "https://github.com/oxc-project/oxc/releases/latest/download/%ZIPNAME%"
call "%~dp0\run_unzip.cmd" "%ZIPNAME%"

move "%EXEFILE%" oxfmt.exe
del "%ZIPNAME%"
