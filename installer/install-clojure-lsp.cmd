@echo off

setlocal

set VERSION=latest

rem FIXME: Windows shell always sets %PROCESSOR_ARCHITECTURE% ["AMD64" || "x86"] even if uses ARM64.
echo Your Architecture is: %PROCESSOR_ARCHITECTURE%
if %PROCESSOR_ARCHITECTURE% == AMD64 (
  set ARCH=amd64
) else (
  echo Unknown architecture: %PROCESSOR_ARCHITECTURE%
  exit /B 1
)

rem FIXME: clojure-lsp releases only AMD64 binary.
set FILENAME=clojure-lsp-native-windows-%ARCH%.zip

set URL=https://github.com/clojure-lsp/clojure-lsp/releases/%VERSION%/download/%FILENAME%
echo Downloading: %URL%
curl -L -O %URL%
call "%~dp0\run_unzip.cmd" %FILENAME%
