#!/bin/sh

set -e

version="v0.0-3624-gd256d779"
os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=$(uname -m)

case $os in
linux)
  platform="linux-static-$arch"
  ;;
darwin)
  platform="macOS"
  ;;
*)
  printf "Operating system '%s' not supported by bash installer" "$os"
  exit 1
  ;;
esac

url="https://github.com/chipsalliance/verible/releases/download/$version/verible-$version-$platform.tar.gz"
archive=$(basename $url)
path_to_binary="verible-$version/bin/verible-verilog-ls"

curl -L -o $archive $url
tar -xzvf $archive $path_to_binary
mv $path_to_binary .
rm -r $archive "verible-$version"
