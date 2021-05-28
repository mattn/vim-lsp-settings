@echo off

setlocal
set VERSION=%1:-0.6.2
curl -L -o elixir-ls.zip "https://github.com/elixir-lsp/elixir-ls/releases/download/v%VERSION%/elixir-ls.zip"
call "%~dp0\run_unzip.cmd" elixir-ls.zip
del elixir-ls.zip

echo @echo off ^

call language_server.bat ^

> elixir-ls.cmd

