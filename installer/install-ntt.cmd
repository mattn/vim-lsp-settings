@echo off

setlocal
set VERSION=0.5
curl -L "https://github.com/nokia/ntt/releases/download/v%VERSION%/ntt_windows_x86_64.tar.gz" | tar xz ntt
