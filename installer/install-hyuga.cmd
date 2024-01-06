@echo off

rem call "%~dp0\pip_install.cmd" hyuga hyuga

rem need to add --system-site-package option

if "x%1" equ "x" goto :EOF
if "x%2" equ "x" goto :EOF

rem python(ver 3.x) or python3 check
echo :where python
where python  2>NUL && goto :python
:python_fail
echo :where python3
where python3 2>NUL && goto :python3
:python3_fail
goto :EOF

:python
rem python is 2 or 3 check(python3 version at python3 grammar)
call python -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)" 2>NUL
if errorlevel 1 goto :python_fail
set PYTHON=python
goto :create_venv

:python3
rem python3 always python 3.x :-)
rem python3 -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)" 2>NUL
rem if errorlevel 1 goto :python3_fail
set PYTHON=python3
goto :create_venv

:create_venv
rem python support slash path split?
echo :call "%PYTHON%" -m venv ./venv
call "%PYTHON%" -m venv --system-site-package ./venv
if not errorlevel 1 goto :install
echo :call "%PYTHON%" -m venv .\venv
call "%PYTHON%" -m venv .\venv
goto :install

:install
rem python command path check (env var set just path&&... need)
where venv\bin\:python      2>NUL && set PYTHON=venv\bin\python&&      goto :generate
where venv\Scripts\:python  2>NUL && set PYTHON=venv\Scripts\python&&  goto :generate
where venv\bin\:python3     2>NUL && set PYTHON=venv\bin\python3&&     goto :generate
where venv\Scripts\:python3 2>NUL && set PYTHON=venv\Scripts\python3&& goto :generate
goto :EOF

:generate
rem get absolute path of bin or Scripts directory
for /f %%V in ("%PYTHON%") do set BINPATH=%%~dpV

rem upgrade pip (windows: use `python -m pip`)
rem and install target package
echo :"%PYTHON%" -m pip install -U pip
"%PYTHON%" -m pip install -U pip
echo :"%PYTHON%" -m pip install hyuga
"%PYTHON%" -m pip install hyuga

rem exec cmd generate
echo :generate hyuga.cmd
echo @echo off ^

"%BINPATH%hyuga" %%* ^

> hyuga.cmd
type hyuga.cmd
