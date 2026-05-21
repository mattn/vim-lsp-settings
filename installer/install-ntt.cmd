@echo off

setlocal
set VERSION=v0.23.2
curl -LO "https://github.com/nokia/ntt/releases/download/%VERSION%/ntt_windows_x86_64.zip"
unzip ntt_windows_x86_64.zip
rm ntt_windows_x86_64.zip
