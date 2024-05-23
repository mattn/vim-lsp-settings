#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

arch=$(uname -m)

case $os in
linux)
  case $(uname -r) in
    *-musl)
      kernel=musl
      ;;
    *)
      kernel=glibc
      ;;
  esac
  if [ "$arch" = "x86_64" ]; then
    if [ "$kernel" = "musl" ]; then
      filename="biome-linux-x64-musl"
    else
      filename="biome-linux-x64"
    fi
  else
    if [ "$kernel" = "musl" ]; then
      filename="biome-linux-arm64-musl"
    else
      filename="biome-linux-arm64"
    fi
  fi
  ;;
darwin)
  if [ "$arch" = "x86_64" ]; then
    filename="biome-darwin-x64"
  else
    filename="biome-darwin-arm64"
  fi
  ;;
esac

curl -L -o "$filename" "https://github.com/biomejs/biome/releases/latest/download/$filename"
mv "$filename" biome
chmod +x biome
