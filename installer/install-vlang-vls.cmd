@echo off

git clone --depth=1 https://github.com/vlang/vls vls

echo Compiling vlang/vls...
v -prod -o vlang-vls.exe vls
rd /Q /S vls
