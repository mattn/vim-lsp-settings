#!/bin/bash

set -e

cd $(dirname $0)

./npm_install.sh css-languageserver vscode-css-languageserver-bin
