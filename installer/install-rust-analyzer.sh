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

curl -L -o "rust-analyzer-$platform" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$platform"

mv rust-analyzer-$platform rust-analyzer
chmod +x rust-analyzer
