@echo off
setlocal
set VERSION=2026.01.19
curl -L -o clj-kondo-lsp https://github.com/borkdude/clj-kondo/releases/download/v%VERSION%/clj-kondo-lsp-server-%VERSION%-standalone.jar
