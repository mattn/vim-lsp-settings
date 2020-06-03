@echo off

setlocal
set version=0.9.1
set url=https://github.com/eclipse/che-che4z-lsp-for-cobol/releases/download/%version%/cobol-language-support-%version%.vsix
curl -LO "%url%"
call "%~dp0\run_unzip.cmd" "cobol-language-support-%version%.vsix"

echo @echo off ^

java "-Dline.speparator=\r\n" -jar "%%~dp0\extension\server\lsp-service-cobol-%version%.jar" pipeEnabled ^

> cobol-language-support.cmd

