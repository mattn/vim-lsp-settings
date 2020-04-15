@echo off

curl -LO "https://repo.eclipse.org/content/repositories/lemminx-snapshots/org/eclipse/org.eclipse.lemminx/0.11.0-SNAPSHOT/org.eclipse.lemminx-0.11.0-20200309.180941-1-uber.jar"

setlocal
set VSCODE_XML_VERSION=0.11.0
set LEMMINX_VERSION=0.11.1
set URL=https://github.com/redhat-developer/vscode-xml/releases/download/%VSCODE_XML_VERSION%/redhat.vscode-xml-%VSCODE_XML_VERSION%.vsix
set EXTENTION=redhat.vscode-xml-%VSCODE_XML_VERSION%.vsix
set LEMMINX_JAR=org.eclipse.lemminx-%LEMMINX_VERSION%-uber.jar

curl -L %URL% -o %EXTENTION%
call "%~dp0\run_unzip.cmd" -d vscode-xml %EXTENTION%

del %EXTENTION%
copy vscode-xml\extension\server\%LEMMINX_JAR% .

echo @echo off ^

java -jar %%~dp0\%LEMMINX_JAR% %%* ^

> lemminx.cmd

