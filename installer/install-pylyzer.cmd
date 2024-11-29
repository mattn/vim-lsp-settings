@echo off

call "%~dp0\pip_install.cmd" pylyzer pylyzer

curl -L -o ergup.py https://github.com/mtshiba/ergup/raw/main/ergup.py
"%PYTHON%" -I -c "exec(""try:\n while True: print('n')\nexcept: []"")" | "%PYTHON%" ergup.py
del ergup.py
