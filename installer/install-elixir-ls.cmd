@echo off

setlocal
set VERSION=0.15.1
curl -L -o elixir-ls.zip "https://github.com/elixir-lsp/elixir-ls/releases/download/v%VERSION%/elixir-ls-v%VERSION%.zip"
call "%~dp0\run_unzip.cmd" "elixir-ls-v%VERSION%.zip"
del "elixir-ls-v%VERSION%.zip"

echo @echo off ^

call language_server.bat ^

> elixir-ls.cmd

