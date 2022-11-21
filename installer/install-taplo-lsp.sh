#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

# Releases of taplo-lsp have the tag such as 'release-lsp-${version}'
latest="0.2.6"

case $os in
linux)
  platform="x86_64-unknown-linux-gnu"
  ;;
darwin)
  platform="x86_64-apple-darwin-gnu"
  ;;
esac

curl -L "https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-$platform.tar.gz" | tar xz

mv taplo taplo-lsp
chmod +x taplo-lsp
