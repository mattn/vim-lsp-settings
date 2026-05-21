#!/bin/sh

set -e

version="0.10.0"

os=$(uname -s | tr "[:upper:]" "[:lower:]")
architecture=$(uname -m)

case $os in
linux)
  platform="linux-$architecture"
  ;;
darwin)
  case $architecture in
    arm64)
      platform="darwin-aarch64"
      ;;
    *)
      platform="darwin-$architecture"
      ;;
  esac
  ;;
esac

curl -L "https://github.com/tamasfe/taplo/releases/download/$version/taplo-$platform.gz" | gzip -d >taplo-lsp

chmod +x taplo-lsp
