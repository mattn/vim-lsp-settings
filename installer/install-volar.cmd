@echo off

rem if not exist package.json (
rem 	call npm init -y
rem 
rem 	echo {"name":""}>package.json
rem )

rem call npm install @volar/server@0.27.12-alpha.1
rem call npm install typescript@4.3

echo 0^</* :{ ^

  @echo off ^

  node %%~f0 %%* ^

  exit /b %%errorlevel%% ^

:} */0; ^

require('./node_modules/@volar/server/out/index.js') ^

> volar.cmd
