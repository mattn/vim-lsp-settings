#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"

case $os in
linux)
  if [[ $arch == "x86_64" ]]; then
    platform="x86_64-unknown-linux-gnu"
  elif [[ $arch == "aarch64" ]]; then
    platform="aarch64-unknown-linux-gnu"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  if [[ $arch == "x86_64" ]]; then
    platform="x86_64-apple-darwin"
  elif [[ $arch == "aarch64" ]]; then
    platform="aarch64-apple-darwin"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
esac

curl -L -o "rust-analyzer-$platform.gz" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$platform.gz"
gzip -d "rust-analyzer-$platform.gz"

mv rust-analyzer-$platform rust-analyzer
chmod +x rust-analyzer
