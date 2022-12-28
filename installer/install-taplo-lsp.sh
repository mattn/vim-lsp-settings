#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

# Releases of taplo-lsp have the tag such as 'release-lsp-${version}'
latest="0.2.6"

case $os in
linux)
  platform="linux-"$(uname -m)
  ;;
darwin)
  platform="darwin-"$(uname -m)
  ;;
esac

curl -L "https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-$platform.gz" | gzip -d > taplo-lsp

chmod +x taplo-lsp
