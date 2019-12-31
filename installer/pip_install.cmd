@echo off

if "x%1" equ "x" goto :EOF
if "x%2" equ "x" goto :EOF

REM python(ver 3.x) or python3 check
where python  2>NUL && goto :python
:python_fail
where python3 2>NUL && goto :python3
:python3_fail
goto :EOF

:python
REM python is 2 or 3 check(python3 version at python3 grammar)
python -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)" 2>NUL
if errorlevel 1 goto :python_fail

REM python support slash path split?
python -m venv ./venv
if not errorlevel 1 goto :install
python -m venv .\venv
goto :install

:python3
REM python3 always python 3.x :-)
REM python3 -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)" 2>NUL
REM if errorlevel 1 goto :python3_fail

REM python3 support slash path split?
python3 -m venv ./venv
if not errorlevel 1 goto :install
python3 -m venv .\venv
goto :install

:install

REM pip command path check (env var set just path&&... need)
where venv\bin\:pip3     2>NUL && set PIPPATH=venv\bin&&     goto :generate
where venv\Scripts\:pip3 2>NUL && set PIPPATH=venv\Scripts&& goto :generate
goto :EOF

REM pyls exec cmd generate
:generate
%PIPPATH%\pip3 install %2

echo @echo off ^

%%~dp0\%PIPPATH%\%1 %%* ^

> %1.cmd
