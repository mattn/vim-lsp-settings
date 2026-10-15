@echo off

setlocal
set "VERSION=1.7.1"

set "PLATFORM=x86_64"
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" echo Warning: 32-bit Windows is not supported.
if /i "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "PLATFORM=aarch64"
if /i "%PROCESSOR_ARCHITEW6432%"=="ARM64" set "PLATFORM=aarch64"

set "ARCHIVE=glsl_analyzer.zip"

curl -L -o "%ARCHIVE%" "https://github.com/nolanderc/glsl_analyzer/releases/download/v%VERSION%/%PLATFORM%-windows.zip"
call "%~dp0\run_unzip.cmd" "%ARCHIVE%"
del "%ARCHIVE%"
copy bin\glsl_analyzer.exe glsl_analyzer.exe
rd /Q /S bin
.\glsl_analyzer.exe --version
