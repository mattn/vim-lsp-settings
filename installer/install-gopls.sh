#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/gopls ] && rm -rf ../servers/gopls
mkdir ../servers/gopls
cd ../servers/gopls
GOPATH=$(pwd) GOBIN=$(pwd) go get -v -u golang.org/x/tools/cmd/gopls
rm -rf src
