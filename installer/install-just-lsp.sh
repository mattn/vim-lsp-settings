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
  ext="zip"
  ;;
*)
  echo "unknown platform: $os"
  exit 1
  ;;
esac

# Get latest release version
version=$(curl -si 'https://github.com/terror/just-lsp/releases/latest' | grep -ioE '^location: \S+')
version=${version##*/}

curl -L -o "just-lsp.$ext" "https://github.com/terror/just-lsp/releases/download/$version/just-lsp-$version-$platform.$ext"
if [ "$ext" = "zip" ]; then
  unzip -o "just-lsp.$ext" "just-lsp.exe"
else
  tar -xf "just-lsp.$ext" "./just-lsp"
fi
rm -f "just-lsp.$ext"
echo "just-lsp"
./just-lsp --version
