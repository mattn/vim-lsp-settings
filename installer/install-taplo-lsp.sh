#!/bin/sh

set -e

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

curl -L "https://github.com/tamasfe/taplo/releases/latest/download/taplo-full-$platform.gz" | gzip -d >taplo-lsp

chmod +x taplo-lsp
