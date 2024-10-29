#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" vscode-eslint-language-server vscode-langservers-extracted
