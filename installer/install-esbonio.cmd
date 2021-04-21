@echo off

setlocal

echo @echo off ^

%%~dp0\venv\bin\python -m esbonio %%* ^

> esbonio.cmd
