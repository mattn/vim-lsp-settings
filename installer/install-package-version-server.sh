#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"
ext="tar.gz"

case $os in
linux)
  if [ "$arch" = "x86_64" ]; then
    platform="x86_64-unknown-linux-gnu"
  elif [ "$arch" = "aarch64" ]; then
    platform="aarch64-unknown-linux-gnu"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  if [ "$arch" = "x86_64" ]; then
    platform="x86_64-apple-darwin"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="aarch64-apple-darwin"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
mingw64_nt*)
  if [ "$arch" = "x86_64" ]; then
    platform="x86_64-pc-windows-msvc"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="aarch64-pc-windows-msvc"
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

curl -L -o "package-version-server.$ext" "https://github.com/zed-industries/package-version-server/releases/latest/download/package-version-server-$platform.$ext"
if [ "$ext" = "zip" ]; then
  unzip "package-version-server.$ext"
else
  tar -xf "package-version-server.$ext"
fi

chmod +x package-version-server
