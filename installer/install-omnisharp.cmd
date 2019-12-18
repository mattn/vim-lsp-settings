@echo off

cd %~dp0
if exist "..\servers\omnisharp" rd /S /Q  "..\servers\omnisharp"
md "..\servers\omnisharp"
cd "..\servers\omnisharp"
curl -L -o omnisharp-win-x64.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.34.9/omnisharp-win-x64.zip"
unzip omnisharp-win-x64.zip
del omnisharp-win-x64.zip
