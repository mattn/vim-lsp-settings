@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\elixir-ls
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o elixir-ls.zip "https://github.com/JakeBecker/elixir-ls/releases/download/v0.2.25/elixir-ls.zip"
call %installer_dir%\run_unzip elixir-ls.zip
del elixir-ls.zip

echo @echo off ^

call language_server.bat ^

> elixir-ls.cmd

