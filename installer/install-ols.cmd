@echo off

git clone --depth=1 https://github.com/DanielGavin/ols
cd ols
.\build.bat
copy ols.exe ..
rd /Q /S ols
