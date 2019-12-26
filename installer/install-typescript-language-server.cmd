@echo off

cd /d %~dp0

call npm_install tsserver typescript
call npm_install typescript-language-server typescript-language-server
