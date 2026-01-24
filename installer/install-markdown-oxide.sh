#!/bin/sh

set -e

version="v0.25.10"
os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=$(uname -m)

case $os in
linux)
  case $arch in
  x86_64)
    target="x86_64-unknown-linux-gnu"
    ;;
  aarch64|arm64)
    target="aarch64-unknown-linux-gnu"
    ;;
  esac
  ;;
darwin)
  case $arch in
  x86_64)
    target="x86_64-apple-darwin"
    ;;
  arm64)
    target="aarch64-apple-darwin"
    ;;
  esac
  ;;
esac

curl -L -o markdown-oxide "https://github.com/Feel-ix-343/markdown-oxide/releases/download/${version}/markdown-oxide-${version}-${target}"
chmod +x markdown-oxide
