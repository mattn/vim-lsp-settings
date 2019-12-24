#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install css-languageserver vscode-css-languageserver-bin
