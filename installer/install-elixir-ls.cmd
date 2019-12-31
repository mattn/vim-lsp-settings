@echo off

curl -L -o elixir-ls.zip "https://github.com/JakeBecker/elixir-ls/releases/download/v0.2.25/elixir-ls.zip"
call "%~dp0\run_unzip.cmd" elixir-ls.zip
del elixir-ls.zip

echo @echo off ^

call language_server.bat ^

> elixir-ls.cmd

