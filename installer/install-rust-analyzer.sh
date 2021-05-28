#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  platform="x86_64-unknown-linux-gnu"
  ;;
darwin)
  platform="x86_64-apple-darwin"
  ;;
esac

curl -L -o "rust-analyzer-$platform.gz" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$platform.gz"
gzip -d "rust-analyzer-$platform.gz"

mv rust-analyzer-$platform rust-analyzer
chmod +x rust-analyzer
