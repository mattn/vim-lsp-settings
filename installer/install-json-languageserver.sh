#!/bin/sh

set -e

cd $(dirname $0)

./npm_install.sh json-languageserver vscode-json-languageserver-bin
