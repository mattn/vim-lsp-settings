#!/bin/sh

set -e

git clone --depth=1 https://github.com/DanielGavin/ols_
cd ols_ && ./build.sh && cp ols .. && cd .. && rm -rf ols_
