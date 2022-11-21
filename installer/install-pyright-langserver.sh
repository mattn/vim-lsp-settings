#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" pyright-langserver pyright
