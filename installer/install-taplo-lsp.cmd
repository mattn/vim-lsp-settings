@echo off

setlocal

set LATEST=0.2.6
curl -L "https://github.com/tamasfe/taplo/releases/download/release-lsp-%LATEST%/taplo-lsp-windows-x86_64.zip"
call "%~dp0\run_unzip.cmd" taplo-lsp-windows-x86_64.zip
del taplo-lsp-windows-x86_64.zip

%%~dp0\taplo-lsp.exe %%* ^

> taplo-lsp.cmd

