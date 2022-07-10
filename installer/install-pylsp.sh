#!/bin/sh

set -e

"$(dirname "$0")/pip_install.sh" pylsp python-lsp-server
