#!/bin/sh

set -e

# FIXME: official repository is not available for Windows
# git clone https://git.sr.ht/~xerool/fennel-ls src
git clone https://git.sr.ht/~y_sakurai/fennel-ls src
cd src/
make
cp fennel-ls ../
cd ../
rm -rf src/
