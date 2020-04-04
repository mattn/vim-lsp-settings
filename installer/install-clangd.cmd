@echo off

setlocal

echo Downloading clang and LLVM...
curl -L -o LLVM-10.0.0-win64.exe "https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/LLVM-10.0.0-win64.exe"
echo Running setup...

REM Run setup as regular user to avoid a UAC popup
set __COMPAT_LAYER=RUNASINVOKER
md tmp
LLVM-10.0.0-win64.exe /S /D=%cd%\tmp
copy tmp\bin\clangd.exe clangd.exe
del LLVM-10.0.0-win64.exe
rd /Q /S %cd%\tmp
.\clangd.exe --version
