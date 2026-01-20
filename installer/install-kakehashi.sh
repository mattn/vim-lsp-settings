#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"

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
*)
  echo "unknown platform: $os"
  exit 1
  ;;
esac

# Download latest release
url="https://github.com/atusy/kakehashi/releases/latest/download/kakehashi-v0.0.10-${platform}.tar.gz"
curl -L -o "kakehashi-${platform}.tar.gz" "$url"
tar xzf "kakehashi-${platform}.tar.gz"
rm "kakehashi-${platform}.tar.gz"
chmod +x kakehashi
