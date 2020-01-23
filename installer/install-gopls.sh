#!/bin/sh

set -e

GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
rm -rf src
