@echo off

:check_bash
IF EXIST "C:\Program Files\Git\bin\bash.exe" (
  echo Detected: Git Bash x64
  set BASH="C:\Program Files\Git\bin\bash.exe"
) ELSE IF EXIST "C:\Program Files (x86)\Git\bin\bash.exe" (
  echo Detected: Git Bash x86
  set BASH="C:\Program Files (x86)\Git\bin\bash.exe"
) ELSE (
  echo Git Bash not found. Please install Git for Windows.
  echo example:
  echo  winget install Git.Git
  goto :exit
)

echo BASH=%BASH%

:make
copy "%~dp0install-fennel-ls.sh" "%cd%\install-fennel-ls.sh"
%BASH% -c "./install-fennel-ls.sh"

:makebat
echo FIXME: Workaround - need to create a dummy .bat file since vim-lsp-settings verifies the executable's existence.
echo Creating dummy file: fennel-ls.bat
echo "" > fennel-ls.bat

:clean
del "%cd%\install-fennel-ls.sh"

:exit
