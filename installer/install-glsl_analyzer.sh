#!/bin/sh

set -e

version="1.7.1"

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"

case $os in
linux)
  if [ "$arch" = "x86_64" ]; then
    platform="x86_64-linux-musl"
  elif [ "$arch" = "aarch64" ]; then
    platform="aarch64-linux-musl"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  if [ "$arch" = "x86_64" ]; then
    platform="x86_64-macos"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="aarch64-macos"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
mingw64_nt*)
  if [ "$arch" = "x86_64" ]; then
    platform="x86_64-windows"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    platform="aarch64-windows"
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

archive="glsl_analyzer.zip"

curl -L -o "$archive" "https://github.com/nolanderc/glsl_analyzer/releases/download/v$version/$platform.zip"
if command -v unzip >/dev/null 2>&1; then
  unzip -o "$archive"
else
  echo "Need unzip to extract $archive" >&2
  rm -f "$archive"
  exit 1
fi

rm -f "$archive"
chmod +x bin/glsl_analyzer
ln -sf bin/glsl_analyzer .
./glsl_analyzer --version
