#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux) ;;
darwin)
  os="osx"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

version="v0.26.0"
url="https://github.com/d-language-server/dls/releases/download/$version/dls-$version.$os.x86_64.zip"
curl -LO "$url"
unzip "dls-$version.$os.x86_64.zip"
