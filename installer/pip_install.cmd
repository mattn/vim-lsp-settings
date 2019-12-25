@echo off

if "x%1" equ "x" goto :EOF
if "x%2" equ "x" goto :EOF

set server_dir="..\servers\%1"
rd /Q /S "%server_dir%" 2>NUL
md "%server_dir%"
cd "%server_dir%"

where python  && goto :python
:python_fail
where python3 && goto :python3
:python3_fail
goto :EOF

:python
python -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)"
if errorlevel 1 goto :python_fail

python -m venv ./venv
venv\Scripts\pip3 install %2

echo @echo off ^

%%~dp0\venv\Scripts\%1.exe %%* ^

> %1.cmd
goto :EOF

:python3
python3 -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)"
if errorlevel 1 goto :python3_fail

python3 -m venv ./venv
venv\bin\pip3 install %2

echo @echo off ^

%%~dp0\venv\bin\%1.cmd %%* ^

> %1.cmd
goto :EOF
