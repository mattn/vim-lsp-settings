@echo off

call "%~dp0\npm_install" tsserver typescript
call "%~dp0\npm_install" typescript-language-server typescript-language-server
