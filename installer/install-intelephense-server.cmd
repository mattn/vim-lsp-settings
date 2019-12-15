@echo off

cd %~dp0
if exist "..\servers\intelephense-server" rd /S /Q  "..\servers\intelephense-server"
md "..\servers\intelephense-server"
cd "..\servers\intelephense-server"
git clone "https://github.com/bmewburn/vscode-intelephense" .

call npm install

echo @echo off ^

call %%~dp0\node_modules\.bin\intelephense.cmd %%* ^

> intelephense-server.cmd

