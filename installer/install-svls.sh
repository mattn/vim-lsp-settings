#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  os="lnx"
  ;;
darwin)
  os="mac"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

version="v0.1.16"
curl -L -o svls-$version-x86_64-$os.zip "https://github.com/dalance/svls/releases/download/$version/svls-$version-x86_64-$os.zip"
unzip svls-$version-x86_64-$os.zip
rm svls-$version-x86_64-$os.zip
