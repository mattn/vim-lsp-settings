#!/bin/sh

set -e

cd $(dirname $0)

. ./npm.sh
npm_install json-languageserver vscode-json-languageserver-bin
