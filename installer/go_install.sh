#!/bin/bash

# Usage
# $ go_install [EXECUTABLE_NAME] [GO_GET_URLPATH]

set -e

GOPATH=$(pwd)/go
go get "$2"
ln -s "./go/bin/$1" .
