@echo off

setlocal
set VERSION=v0.23.0
set ZIP=elixir-ls-%VERSION%.zip
curl -L -o "%ZIP%" "https://github.com/elixir-lsp/elixir-ls/releases/download/%VERSION%/%ZIP%"
call "%~dp0\run_unzip.cmd" "%ZIP%"
del "%ZIP%"

echo @echo off ^

call language_server.bat ^

> elixir-ls.cmd

