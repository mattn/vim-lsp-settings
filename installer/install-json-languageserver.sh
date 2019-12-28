#!/bin/sh

set -e

cd $(dirname $0)

./npm_install json-languageserver vscode-json-languageserver-bin
