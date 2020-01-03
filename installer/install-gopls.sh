#!/bin/sh

set -e

GOPATH=$(pwd) GOBIN=$(pwd) go get -v -u golang.org/x/tools/gopls
rm -rf src
