@echo off

call "%~dp0\npm_install.cmd" tsserver typescript
call "%~dp0\npm_install.cmd" vtsls @vtsls/language-server
