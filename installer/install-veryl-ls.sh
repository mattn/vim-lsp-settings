#!/bin/sh

set -e

version="v0.20.0"

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  os="linux"
  ;;
darwin)
  os="mac"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

curl -L -o veryl-x86_64-$os.zip "https://github.com/veryl-lang/veryl/releases/download/$version/veryl-x86_64-$os.zip"
unzip veryl-x86_64-$os.zip
rm veryl
rm veryl-x86_64-$os.zip
