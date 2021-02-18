@echo off

call "%~dp0\npm_install.cmd" tsserver typescript
call "%~dp0\npm_install.cmd" angular-language-server @angular/language-server

echo @echo off ^

node %%~dp0\node_modules\@angular\language-server\index.js --ngProbeLocations %%~dp0\node_modules\@angular\language-service --tsProbeLocations %%~dp0\node_modules\typescript %%* ^

> angular-language-server.cmd

