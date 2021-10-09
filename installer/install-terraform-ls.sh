#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
version=$(basename $(curl -Ls -o /dev/null -w %\{url_effective\} https://github.com/hashicorp/terraform-ls/releases/latest))
filename="terraform-ls_$(echo "$version" | awk '{print substr($0, 2)}').zip"

case $os in
darwin | linux)
  url="https://github.com/hashicorp/terraform-ls/releases/download/${version}/terraform-ls_$(echo "$version" | awk '{print substr($0, 2)}')_${os}_amd64.zip"
  curl -L "$url" -o "$filename"
  ;;
*)
  printf "%s doesn't supported" "$os"
  exit 1
  ;;

esac

unzip "$filename"
rm "$filename"
