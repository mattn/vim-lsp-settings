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
  echo "unknow platform: $os"
  exit 1
  ;;
esac

# Get latest release version
version=$(curl -si 'https://github.com/crisidev/bacon-ls/releases/latest' | grep -ioE '^location: \S+')
version=${version##*/}

# Install bacon-ls
curl -L -o "bacon-ls.$ext" "https://github.com/crisidev/bacon-ls/releases/download/$version/bacon-ls-$version-$platform.$ext"
if [ "$ext" = "zip" ]; then
  unzip "bacon-ls.$ext"
  mv "target/$platform/release/bacon-ls.exe" .
  rm -rf "target"
else
  tar -xf "bacon-ls.$ext"
fi
rm -rf "bacon-ls.$ext"
echo "bacon-ls"
./bacon-ls --version

# Install bacon
if ! which bacon >/dev/null 2>&1; then
  cargo install --locked bacon
fi
bacon --version
