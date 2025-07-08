@echo off
setlocal

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set architecture=x86_64
) else if "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    set architecture=aarch64
) else if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=x86
) else (
    echo Unkown architecture, unable to install Taplo Language Server.
    exit /b
)

set taploFile=taplo-windows-%architecture%.zip
set downloadLocation=https://github.com/tamasfe/taplo/releases/latest/download/%taploFile%
curl -L -o %taploFile% %downloadLocation%
call "%~dp0\run_unzip.cmd" %taploFile%
del %taploFile%

echo @echo off ^

%%~dp0\taplo.exe %%* ^

> taplo-lsp.cmd
