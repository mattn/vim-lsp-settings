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

version="2020-02-18"
curl -L -o ra_lsp_server-$platform "https://github.com/rust-analyzer/rust-analyzer/releases/download/$version/rust-analyzer-$platform"

mv rust-analyzer-$platform rust-analyzer
chmod +x rust-analyzer
