#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
version="0.15.0"
filename="terraform-ls_${version}.zip"

case $os in
darwin | linux)
  url="https://github.com/hashicorp/terraform-ls/releases/download/v${version}/terraform-ls_${version}_${os}_amd64.zip"
  curl -L "$url" -o "$filename"
  ;;
*)
  printf "%s doesn't supported" "$os"
  exit 1
  ;;

esac

unzip "$filename"
rm "$filename"
