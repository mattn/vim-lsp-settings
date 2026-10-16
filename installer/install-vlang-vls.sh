#!/bin/sh

set -e

git clone --depth=1 https://github.com/vlang/vls vls

echo 'Compiling vlang/vls...'
v -prod -o vlang-vls vls
rm -rf vls
