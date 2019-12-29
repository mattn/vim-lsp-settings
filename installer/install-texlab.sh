#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/texlab"
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

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

url="https://github.com/latex-lsp/texlab/releases/download/v1.8.0/texlab-x86_64-$os.tar.gz"
curl -LO "$url"
tar xzvf texlab-x86_64-$os.tar.gz
