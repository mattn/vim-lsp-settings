@echo off

git clone --depth=1 https://github.com/erlang-ls/erlang_ls .
make

echo @echo off ^

%%~dp0\_build\default\bin\erlang_ls %%* ^

> erlang-ls.cmd
