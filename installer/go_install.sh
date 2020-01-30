#!/bin/bash

# Usage
# $ go_install [GO_GET_URLPATH]

set -e

GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v -u $1
rm -rf src
