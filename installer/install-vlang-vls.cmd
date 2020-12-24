@echo off

git clone --depth=1 https://github.com/vlang/vls .

echo Compiling vlang/vls...
v -prod cmd/vls
move cmd/vls/vls.exe vlang-vls.exe
rd /Q /S -rf instructions.png cmd jsonrpc lsp vls tests
