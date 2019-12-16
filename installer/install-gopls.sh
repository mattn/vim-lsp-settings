#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/gopls ] && rm -rf ../servers/gopls
mkdir ../servers/gopls
cd ../servers/gopls
go get -u golang.org/x/tools/cmd/gopls
rm -rf src
