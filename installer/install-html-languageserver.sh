#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" html-languageserver vscode-html-languageserver-bin
