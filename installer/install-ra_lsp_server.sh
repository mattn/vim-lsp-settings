#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
    linux)
        platform="linux"
        ;;
    darwin)
        platform="mac"
        ;;
esac

curl -L -o ra_lsp_server-$platform "https://github.com/rust-analyzer/rust-analyzer/releases/download/2020-01-27/ra_lsp_server-$platform"

mv ra_lsp_server-$platform ra_lsp_server
