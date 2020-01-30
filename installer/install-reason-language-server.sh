#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux) ;;
darwin)
  os="macos"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

version="1.7.5"
url="https://github.com/jaredly/reason-language-server/releases/download/$version/rls-$os.zip"
curl -LO "$url"
unzip "rls-$os.zip"

ln -s "./rls-$os/reason-language-server" .
