@echo off

setlocal

cd /d %~dp0

set server_dir=..\servers\clojure-lsp
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

curl -L -o clojure-lsp.cmd https://github.com/snoe/clojure-lsp/releases/download/release-20191202T142318/clojure-lsp
