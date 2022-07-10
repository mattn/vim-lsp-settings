#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" css-languageserver vscode-css-languageserver-bin
