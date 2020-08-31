#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux) ;;
darwin)
  os="osx"
  ;;
*)
  echo "$os is not supported by installer"
  exit 1
  ;;
esac

version="0.6.0"
filename="serve-d_$version-$os-x86_64.tar.xz"
url="https://github.com/Pure-D/serve-d/releases/download/v$version/$filename"
curl -L "$url" | unxz | tar x
