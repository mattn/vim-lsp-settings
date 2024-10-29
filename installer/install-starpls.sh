#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"

case $os in
linux)
  if [ "$arch" = "x86_64" ]; then
    platform="linux-amd64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  if [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="darwin-arm64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
mingw64_nt*)
  if [ "$arch" = "x86_64" ]; then
    platform="windows-amd64.exe"
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

curl -L -o "starpls" "https://github.com/withered-magic/starpls/releases/latest/download/starpls-$platform"

chmod +x starpls
