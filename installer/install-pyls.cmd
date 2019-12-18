@echo off

cd %~dp0
if exist "..\servers\pyls" rd /S /Q  "..\servers\pyls"
md "..\servers\pyls"
cd "..\servers\pyls"

python3 -m venv ./venv
venv\bin\pip3 install python-language-server

echo @echo off ^

venv\bin\pyls ^

> pyls.cmd

