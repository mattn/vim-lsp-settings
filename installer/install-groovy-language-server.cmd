@echo off

git clone --depth=1 https://github.com/prominic/groovy-language-server .
.\gradlew build

echo @echo off ^

java -jar %%~dp0\build\libs\groovy-language-server-all.jar %%*

> groovy-language-server.cmd
