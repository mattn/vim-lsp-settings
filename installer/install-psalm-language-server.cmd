@echo off

call composer require vimeo/psalm

echo @echo off ^

call %%~dp0\vendor\bin\psalm-language-server.cmd %%* ^

> %1.cmd

