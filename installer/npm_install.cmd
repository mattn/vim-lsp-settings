@echo off

if "x%1" equ "x" goto :EOF
if "x%2" equ "x" goto :EOF

if not exist package.json (
	call npm init -y

	echo {"name":""}>package.json
)


call npm install "%2"

echo @echo off ^

call ^"%%~dp0\node_modules\.bin\%1.cmd^" %%* ^

> "%1.cmd"
