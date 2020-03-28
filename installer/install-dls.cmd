@echo off

curl -L -o dls-v0.26.0.windows.x86_64.zip https://github.com/d-language-server/dls/releases/download/v0.26.0/dls-v0.26.0.windows.x86_64.zip"
call "%~dp0\run_unzip.cmd" dls-v0.26.0.windows.x86_64.zip
del dls-v0.26.0.windows.x86_64.zip
