@echo off

call "%~dp0\npm_install.cmd" tsserver typescript
call "%~dp0\npm_install.cmd" angular-language-service @angular/language-service
