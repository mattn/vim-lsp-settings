@echo off

cd %~dp0
if exist "..\servers\solargraph" rd /S /Q  "..\servers\solargraph"
md "..\servers\solargraph"
cd "..\servers\solargraph"
git clone "https://github.com/castwide/solargraph" .

call bundle install --path vendor/bundle

echo @echo off ^

bundle exec ruby %%~dp0\bin/solargraph stdio ^

> solargraph.cmd

