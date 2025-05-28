@echo off

setlocal
curl -L -o server.zip "https://download-cdn.jetbrains.com/kotlin-lsp/0.252.17811/kotlin-0.252.17811.zip"
call "%~dp0\run_unzip.cmd" server.zip
del server.zip

curl -L -o kotlin-lsp.cmd "https://raw.githubusercontent.com/Kotlin/kotlin-lsp/refs/heads/main/scripts/kotlin-lsp.cmd"
