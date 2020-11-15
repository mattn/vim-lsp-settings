@echo off

if not exist package.json (
	call npm init -y

	echo {"name":""}>package.json
)


call npm install "@prisma/engines"

echo @echo off ^

call %%~dp0\node_modules\@prisma\engines\prisma-fmt-windows.exe %%* ^

> prisma-fmt.exe

call "%~dp0\npm_install.cmd" prisma-langauge-server "@prisma/language-server"
