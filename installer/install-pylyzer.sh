#!/bin/sh

set -e

"$(dirname "$0")/pip_install.sh" pylyzer pylyzer

curl -L -o ergup.py https://github.com/mtshiba/ergup/raw/main/ergup.py
yes n | ./venv/bin/python3 ergup.py
rm ergup.py
