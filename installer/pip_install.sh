#!/usr/bin/env bash

# Usage
# $ pip_install [EXECUTABLE_NAME] [PYPI_NAME]

set -e

python3 -m venv ./venv --system-site-packages
./venv/bin/pip3 install -U pip
./venv/bin/pip3 install "$2"
ln -s "./venv/bin/$1" .
