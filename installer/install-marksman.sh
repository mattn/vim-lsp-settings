#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  platform="linux"
  ;;
darwin)
  platform="macos"
  ;;
esac

curl -L -o marksman "https://github.com/artempyanykh/marksman/releases/latest/download/marksman-$platform"
chmod +x marksman
