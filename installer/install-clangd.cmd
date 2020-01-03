@echo off

setlocal

cd /d %~dp0

set installer_dir=%cd%
set server_dir=..\servers\clangd
if exist %server_dir% rd /Q /S "%server_dir%"
md "%server_dir%"
cd /d "%server_dir%"

echo Downloading clang and LLVM...
curl -L -o LLVM-9.0.0-win64.exe "http://releases.llvm.org/9.0.0/LLVM-9.0.0-win64.exe"
echo Running setup...

REM Run setup as regular user to avoid a UAC popup
set __COMPAT_LAYER=RUNASINVOKER
md tmp
LLVM-9.0.0-win64.exe /S /D=%cd%\tmp
copy tmp\bin\clangd.exe clangd.exe
del LLVM-9.0.0-win64.exe
rd /Q /S %cd%\tmp
.\clangd.exe --version
