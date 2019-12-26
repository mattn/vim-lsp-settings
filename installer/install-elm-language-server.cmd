@echo off

cd /d %~dp0

call npm_install elm-language-server "@elm-tooling/elm-language-server"
