#!/usr/bin/env bash
git clone --depth=1 https://github.com/vlang/vls .

echo 'Compiling vlang/vls...'
v -prod cmd/vls
mv cmd/vls/vls vlang-vls
rm -rf instructions.png cmd jsonrpc lsp vls tests
