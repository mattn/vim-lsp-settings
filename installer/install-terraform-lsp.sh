#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
version="0.0.10"

case $os in
darwin | linux)
  url="https://github.com/juliosueiras/terraform-lsp/releases/download/v${version}/terraform-lsp_${version}_${os}_amd64.tar.gz"
  curl -L "$url" | tar zx
  ;;
*)
  printf "%s doesn't supported" "$os"
  exit 1
  ;;

esac
