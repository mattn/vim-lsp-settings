@echo off

REM Usage
REM : pip_install [EXECUTABLE_NAME] [PYPI_NAME]

if "x%1" equ "x" goto :EOF
if "x%2" equ "x" goto :EOF

REM python(ver 3.x) or python3 check
echo :where python
where python  2>NUL && goto :python
:python_fail
echo :where python3
where python3 2>NUL && goto :python3
:python3_fail
goto :EOF

:python
REM python is 2 or 3 check(python3 version at python3 grammar)
call python -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)" 2>NUL
if errorlevel 1 goto :python_fail
set PYTHON=python
goto :create_venv

:python3
REM python3 always python 3.x :-)
REM python3 -c "import sys; from distutils.version import LooseVersion;sys.exit(0 if (LooseVersion(sys.version) > LooseVersion('3')) else 1)" 2>NUL
REM if errorlevel 1 goto :python3_fail
set PYTHON=python3
goto :create_venv

:create_venv
REM python support slash path split?
echo :call "%PYTHON%" -m venv ./venv
call "%PYTHON%" -m venv ./venv
if not errorlevel 1 goto :install
echo :call "%PYTHON%" -m venv .\venv
call "%PYTHON%" -m venv .\venv
goto :install

:install
REM python command path check (env var set just path&&... need)
where venv\bin\:python      2>NUL && set PYTHON=venv\bin\python&&      goto :generate
where venv\Scripts\:python  2>NUL && set PYTHON=venv\Scripts\python&&  goto :generate
where venv\bin\:python3     2>NUL && set PYTHON=venv\bin\python3&&     goto :generate
where venv\Scripts\:python3 2>NUL && set PYTHON=venv\Scripts\python3&& goto :generate
goto :EOF

:generate
REM get absolute path of bin or Scripts directory
for /f %%V in ("%PYTHON%") do set BINPATH=%%~dpV

REM upgrade pip (windows: use `python -m pip`)
REM and install target package
echo :"%PYTHON%" -m pip install -U pip
"%PYTHON%" -m pip install -U pip
echo :"%PYTHON%" -m pip install %2
"%PYTHON%" -m pip install %2

REM exec cmd generate
echo :generate %1.cmd
echo @echo off ^

"%BINPATH%%1" %%* ^

> %1.cmd
type %1.cmd
