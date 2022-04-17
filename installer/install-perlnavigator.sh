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

url="https://github.com/bscan/PerlNavigator/releases/latest/download/perlnavigator-$os-x86_64.zip"
curl -L "$url" | tar xzv
