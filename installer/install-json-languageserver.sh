#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" vscode-json-languageserver vscode-json-languageserver
ln -s vscode-json-languageserver json-languageserver
