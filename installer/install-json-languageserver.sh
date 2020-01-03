#!/bin/sh

set -e

"$(dirname $0)/npm_install.sh" json-languageserver vscode-json-languageserver-bin
