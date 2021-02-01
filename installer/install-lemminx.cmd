@echo off

setlocal
set VERSION=0.14.1
set URL=https://repo.eclipse.org/content/repositories/lemminx-releases/org/eclipse/lemminx/org.eclipse.lemminx/%VERSION%/org.eclipse.lemminx-%VERSION%-uber.jar
set LEMMINX_JAR=org.eclipse.lemminx-%VERSION%-uber.jar

curl -L %URL% -o %LEMMINX_JAR%

echo @echo off ^

java -jar %%~dp0\%LEMMINX_JAR% %%* ^

> lemminx.cmd

