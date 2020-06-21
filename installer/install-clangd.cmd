@echo off

setlocal
set VERSION=10.0.0
echo Downloading clang and LLVM...
curl -L -o LLVM-%VERSION%-win64.exe "https://github.com/llvm/llvm-project/releases/download/llvmorg-%VERSION%/LLVM-%VERSION%-win64.exe"
echo Running setup...

rem Run setup as regular user to avoid a UAC popup
set __COMPAT_LAYER=RUNASINVOKER
md tmp
LLVM-%VERSION%-win64.exe /S /D=%cd%\tmp
copy tmp\bin\clangd.exe clangd.exe
del LLVM-%VERSION%-win64.exe
rd /Q /S %cd%\tmp
.\clangd.exe --version
