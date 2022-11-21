#!/bin/sh

set -e

os="$(uname -s | tr "[:upper:]" "[:lower:]")"
arch="$(uname -m)"

case $os in
linux)
  os_fixed="linux"
  if [ "$arch" = "x86_64" ]; then
    platform="amd64"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="aarch64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  os_fixed="macos"
  if [ "$arch" = "x86_64" ]; then
    platform="amd64"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="aarch64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
mingw64_nt*)
  os_fixed="windows"
  if [ "$arch" = "x86_64" ]; then
    platform="amd64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
*)
  echo "unknow platform: $os"
  exit 1
  ;;
esac

version="latest"
filename="clojure-lsp-native-${os_fixed}-${platform}.zip"
url="https://github.com/clojure-lsp/clojure-lsp/releases/${version}/download/${filename}"
curl -L -O ${url}
unzip ${filename}
chmod +x clojure-lsp
