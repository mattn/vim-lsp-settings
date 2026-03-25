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
url="https://github.com/Feel-ix-343/markdown-oxide/releases/latest/download/markdown-oxide-v0.25.10-${platform}.tar.gz"
curl -L -o "markdown-oxide-${platform}.tar.gz" "$url"
tar xzf "markdown-oxide-${platform}.tar.gz"
mv markdown-oxide-v0.25.10-${platform}/markdown-oxide markdown-oxide
rm "markdown-oxide-${platform}.tar.gz"
chmod +x markdown-oxide
