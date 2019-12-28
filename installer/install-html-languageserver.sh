#!/bin/bash

set -e

cd $(dirname $0)

./npm_install html-languageserver vscode-html-languageserver-bin
