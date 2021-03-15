@echo off

raco pkg install racket-langserver

echo @echo off ^

%%~dp0\racket.exe -l racket-langserver %%* ^

> racket-lsp.cmd
