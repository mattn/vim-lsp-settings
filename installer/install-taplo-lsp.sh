#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  platform="linux-"$(uname -m)
  ;;
darwin)
  platform="darwin-"$(uname -m)
  ;;
esac

curl -L "https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-$platform.gz" | gzip -d >taplo-lsp

chmod +x taplo-lsp
