#!/bin/sh

# Usage
# $ go_install [GO_GET_URLPATH]

set -e

GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go install -v "$1"
GOPATH=$(pwd) GO111MODULE=on go clean -modcache
rm -rf src pkg 2>/dev/null
