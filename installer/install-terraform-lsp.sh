#!/bin/bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
version="0.0.9"
server_dir="../servers/terraform-lsp"

cd $(dirname $0)
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

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
