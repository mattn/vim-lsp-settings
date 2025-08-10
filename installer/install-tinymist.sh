#!/bin/sh

set -e

os="$(uname -s | tr "[:upper:]" "[:lower:]")"
arch=$(uname -m)

case $arch in
x86_64)
  arch="x64"
  ;;
arm64) ;;
aarch64)
  arch="arm64"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

case "${os}" in
darwin) ;;
linux) ;;
*)
  echo >&2 "$os is not supported"
  exit 1
  ;;
esac

curl -L -o tinymist "https://github.com/Myriad-Dreamin/tinymist/releases/latest/download/tinymist-${os}-${arch}"
chmod +x tinymist
