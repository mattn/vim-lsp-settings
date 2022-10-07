@echo off

setlocal
curl -LO "https://github.com/nokia/ntt/releases/latest/download/ntt_windows_x86_64.tar.gz"
tar xvf ntt_windows_x86_64.tar.gz
rm ntt_windows_x86_64.tar.gz
