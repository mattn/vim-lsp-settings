@echo off

curl -o install.vsh "https://raw.githubusercontent.com/v-analyzer/v-analyzer/master/install.vsh"

for /f "delims=" %%a in (install.vsh) do (
  set line=%%a
  setlocal enabledelayedexpansion
  echo !line:'~/.config/v-analyzer='.!>>install2.vsh
  endlocal
)

v install2.vsh
del install.vsh install2.vsh
move bin\v-analyzer.exe .
