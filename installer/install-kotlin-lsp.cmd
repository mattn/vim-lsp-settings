@echo off

setlocal

if not %PROCESSOR_ARCHITECTURE%==AMD64 (
  echo %PROCESSOR_ARCHITECTURE% is not supported
  exit /b 1
)

set version=261.13587.0

curl -L -o server.zip "https://download-cdn.jetbrains.com/kotlin-lsp/%version%/kotlin-lsp-%version%-win-x64.zip"
call "%~dp0\run_unzip.cmd" server.zip
del server.zip
