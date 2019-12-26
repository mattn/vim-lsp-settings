@echo off

setlocal

cd /d %~dp0

set server_dir=..\servers\solargraph
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

git clone "https://github.com/castwide/solargraph" .

call bundle install --path vendor/bundle

echo @echo off ^

bundle exec ruby %%~dp0\bin/solargraph stdio ^

> solargraph.cmd

