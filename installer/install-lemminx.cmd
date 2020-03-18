@echo off

curl -LO "https://repo.eclipse.org/content/repositories/lemminx-snapshots/org/eclipse/org.eclipse.lemminx/0.11.0-SNAPSHOT/org.eclipse.lemminx-0.11.0-20200309.180941-1-uber.jar"

echo @echo off ^

java -jar %%~dp0\org.eclipse.lemminx-0.11.0-20200309.180941-1-uber.jar ^

> lemminx.cmd

