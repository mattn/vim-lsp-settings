@echo off

curl -LO "https://dl.bintray.com/lsp4xml/releases/org/lsp4xml/org.eclipse.lsp4xml/0.9.1/org.eclipse.lsp4xml-0.9.1-uber.jar"

echo @echo off ^

java -jar %%~dp0\org.eclipse.lsp4xml-0.9.1-uber.jar ^

> lsp4xml.cmd

