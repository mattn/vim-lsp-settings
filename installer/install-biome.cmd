@echo off

setlocal
curl -L -o biome-win32-x64.exe "https://github.com/biomejs/biome/releases/latest/download/biome-win32-x64.exe"
move biome-win32-x64.exe biome.exe
