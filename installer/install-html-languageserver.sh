#!/bin/bash

set -e

cd $(dirname $0)

./npm_install.sh html-languageserver vscode-html-languageserver-bin
