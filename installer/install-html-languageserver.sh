#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install html-languageserver vscode-html-languageserver-bin
