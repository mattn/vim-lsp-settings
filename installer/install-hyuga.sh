#!/bin/sh

set -e

#"$(dirname "$0")/pip_install.sh" hyuga hyuga

# need to add --system-site-package option
python3 -m venv --system-site-package ./venv
./venv/bin/pip3 install -U pip
./venv/bin/pip3 install hyuga
ln -s "./venv/bin/hyuga" .
