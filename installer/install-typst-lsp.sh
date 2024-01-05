#!/bin/sh

set -e
#set -o pipefail

os="$(uname -s | tr "[:upper:]" "[:lower:]")"
arch=$(uname -m)

case $arch in
x86_64) ;;
arm64)
  arch="aarch64"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

case "${os}" in
darwin)
  url="https://github.com/nvarner/typst-lsp/releases/latest/download/typst-lsp-${arch}-apple-darwin"
  ;;
linux)
  url="https://github.com/nvarner/typst-lsp/releases/latest/download/typst-lsp-${arch}-unknown-linux-gnu"
  ;;
*)
  echo >&2 "$os is not supported"
  exit 1
  ;;
esac

curl -L -o typst-lsp "$url" 
chmod +x typst-lsp
