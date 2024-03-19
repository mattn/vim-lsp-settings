#!/bin/sh

set -e

git clone --depth=1 https://github.com/DanielGavin/ols
cd ols && ./build.sh && cp ols .. && cd .. && rm -rf ols
