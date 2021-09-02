@echo off

if not exist package.json (
	call npm init -y

	echo {"name":""}>package.json
)

call npm install @volar/server@0.27.12-alpha.1
call npm install typescript@4.3

echo 0^</* :{ ^

  @echo off ^

  node %%~f0 %%* ^

  exit /b %%errorlevel%% ^

:} */0; ^

require('./node_modules/@volar/server/out/index.js') ^

> volar.cmd
