#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=$(uname -m)

case $os in
linux) ;;
darwin)
  os="macos"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

case $arch in
x86_64) ;;
arm64)
  if [ "$os" == "linux" ]; then
    printf "%s doesn't supported by bash installer" "$os"
    exit 1
  fi
  arch="aarch64"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac


url="https://github.com/latex-lsp/texlab/releases/latest/download/texlab-$arch-$os.tar.gz"
curl -L "$url" | tar xzv
