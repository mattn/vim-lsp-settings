@echo off

call "%~dp0\pip_install.cmd" esbonio esbonio[lsp]
rem del esboniio

echo @echo off ^

%%~dp0\venv\bin\python -m esbonio %%* ^

> esbonio.cmd
