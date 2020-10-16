@echo off

nimble -y --nimbledir=%CD% install nimlsp

echo @echo off ^

call %%~dp0\bin\nimlsp.cmd  %%* ^

> nimlsp.cmd
