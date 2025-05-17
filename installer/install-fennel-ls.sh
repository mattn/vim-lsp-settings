#!/bin/sh

set -e

git clone https://git.sr.ht/~y_sakurai/fennel-ls src
cd src/
make
cp fennel-ls ../
cd ../
rm -rf src/
