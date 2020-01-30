#!/usr/bin/env bash

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

version="2020-01-29"
curl -L -o ra_lsp_server-$platform "https://github.com/rust-analyzer/rust-analyzer/releases/download/$version/ra_lsp_server-$platform"

mv ra_lsp_server-$platform ra_lsp_server
chmod +x ra_lsp_server
