#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"

case $os in
linux)
  if [ "$arch" = "x86_64" ]; then
    file="systemd-lsp-x86_64-unknown-linux-gnu"
  else
    echo "unknown architecture: $arch"
    exit 1
  fi
  ;;
darwin)
  if [ "$arch" = "x86_64" ]; then
    file="systemd-lsp-x86_64-apple-darwin"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    file="systemd-lsp-aarch64-apple-darwin"
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

curl -L -o "systemd-lsp" "https://github.com/JFryy/systemd-lsp/releases/download/v2025.07.10/$file"

chmod +x systemd-lsp
