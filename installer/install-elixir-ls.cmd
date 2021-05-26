@echo off

setlocal
set VERSION=0.7.0
curl -L -o elixir-ls.zip "https://github.com/elixir-lsp/elixir-ls/releases/download/v%VERSION%/elixir-ls.zip"
call "%~dp0\run_unzip.cmd" elixir-ls.zip
del elixir-ls.zip

echo @echo off ^

call language_server.bat ^

> elixir-ls.cmd

