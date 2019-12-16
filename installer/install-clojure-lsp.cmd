@echo off

cd %~dp0
if exist "..\servers\clojure-lsp" rd /S /Q  "..\servers\clojure-lsp"
md "..\servers\clojure-lsp"
cd "..\servers\clojure-lsp"
curl -L -o clojure-lsp.cmd https://github.com/snoe/clojure-lsp/releases/download/release-20191202T142318/clojure-lsp
