@echo off

setlocal
call luarocks install --tree "%CD%" digestif
echo @"%%~dp0\bin\digestif.bat" %%* > digestif.cmd
