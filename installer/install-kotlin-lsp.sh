#!/bin/sh

set -e

os="$(uname -s | tr "[:upper:]" "[:lower:]")"
arch="$(uname -m)"

case $os in
darwin)
  os=mac
  ;;
linux) ;;
*)
  echo "$os is not supported"
  exit 1
  ;;
esac

case $arch in
aarch64) ;;
arm64)
  arch=aarch64
  ;;
x86_64)
  arch=x64
  ;;
*)
  echo "$arch is not supported"
  exit 1
  ;;
esac

version=261.13587.0

curl -L -o server.zip "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-lsp-${version}-${os}-${arch}.zip"
unzip server.zip
rm server.zip
chmod +x kotlin-lsp.sh
ln -s kotlin-lsp.sh kotlin-lsp
