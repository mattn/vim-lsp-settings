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

curl -L -o perlnavigator-$os-x86_64.zip "https://github.com/bscan/PerlNavigator/releases/latest/download/perlnavigator-$os-x86_64.zip"
unzip perlnavigator-$os-x86_64.zip
mv perlnavigator-os-x86_64/perlnavigator .
rm -rf perlnavigator-os-x86_64 perlnavigator-os-x86_64.zip

