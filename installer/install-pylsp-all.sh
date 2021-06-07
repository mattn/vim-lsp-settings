#!/usr/bin/env bash

set -e

"$(dirname "$0")/pip_install.sh" pylsp 'python-lsp-server[all]'
mv pylsp pylsp-all
