#!/usr/bin/env bash

set -e

os="$(uname -s | tr "[:upper:]" "[:lower:]")"
arch="$(uname -m)"

case $os in
linux)
  if [[ $arch == "x86_64" ]]; then
    platform="linux-x64"
  elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    platform="linux-arm64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  if [[ $arch == "x86_64" ]]; then
    platform="darwin-x64"
  elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    platform="darwin-arm64"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
mingw64_nt*)
  if [[ $arch == "x86_64" ]]; then
    platform="win32-x64"
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

version="v3.0.0"
url="https://github.com/sumneko/vscode-lua/releases/download/$version/vscode-lua-$version-$platform.vsix"
asset="vscode-lua.vsix"

curl -L "$url" -o "$asset"
unzip "$asset"
rm "$asset"

mv extension/server/bin/lua-language-server lua-language-server
chmod +x lua-language-server
